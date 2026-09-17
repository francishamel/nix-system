"""A local, privacy-preserving viewer for ai-work-trace OTLP JSONL data."""

import argparse
import json
import webbrowser
from collections import Counter
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlparse


def value(attribute):
    """Extract the scalar value from OTLP's typed JSON representation."""
    return next(iter(attribute.get("value", {}).values()), None)


def attributes(items):
    return {item["key"]: value(item) for item in items or []}


def records(trace_file):
    if not trace_file.exists():
        return []
    result = []
    with trace_file.open(encoding="utf-8") as stream:
        for line in stream:
            try:
                result.append(json.loads(line))
            except json.JSONDecodeError:
                pass
    return result


def summary(trace_file):
    services, event_names, span_names, metric_names = (Counter() for _ in range(4))
    logs = spans = metrics = 0
    sessions = set()
    for batch in records(trace_file):
        for resource_log in batch.get("resourceLogs", []):
            service = attributes(
                resource_log.get("resource", {}).get("attributes")
            ).get("service.name", "unknown")
            for scope in resource_log.get("scopeLogs", []):
                for log in scope.get("logRecords", []):
                    logs += 1
                    attrs = attributes(log.get("attributes"))
                    services[service] += 1
                    event_names[attrs.get("event.name", "unnamed event")] += 1
                    if attrs.get("session.id"):
                        sessions.add(attrs["session.id"])
        for resource_span in batch.get("resourceSpans", []):
            service = attributes(
                resource_span.get("resource", {}).get("attributes")
            ).get("service.name", "unknown")
            for scope in resource_span.get("scopeSpans", []):
                for span in scope.get("spans", []):
                    spans += 1
                    services[service] += 1
                    span_names[span.get("name", "unnamed span")] += 1
                    attrs = attributes(span.get("attributes"))
                    if attrs.get("session.id"):
                        sessions.add(attrs["session.id"])
        for resource_metric in batch.get("resourceMetrics", []):
            service = attributes(
                resource_metric.get("resource", {}).get("attributes")
            ).get("service.name", "unknown")
            for scope in resource_metric.get("scopeMetrics", []):
                for metric in scope.get("metrics", []):
                    metrics += 1
                    services[service] += 1
                    metric_names[metric.get("name", "unnamed metric")] += 1
    return {
        "traceFile": str(trace_file),
        "fileBytes": trace_file.stat().st_size if trace_file.exists() else 0,
        "logs": logs,
        "spans": spans,
        "metrics": metrics,
        "sessions": len(sessions),
        "services": services.most_common(),
        "events": event_names.most_common(20),
        "spansByName": span_names.most_common(20),
        "metricsByName": metric_names.most_common(20),
    }


PAGE = r"""<!doctype html><meta charset="utf-8"><title>AI work trace</title>
<style>
:root { color-scheme: dark; font: 16px system-ui; background:#1e1e2e; color:#cdd6f4 }
body { max-width:1100px; margin:40px auto; padding:0 20px } h1 { margin-bottom:4px }
p { color:#a6adc8 }.cards { display:grid; grid-template-columns:repeat(auto-fit,minmax(140px,1fr)); gap:12px; margin:24px 0 }
.card, section { background:#313244; border-radius:10px; padding:16px }.number { font-size:1.7rem; font-weight:bold; color:#89b4fa }
section { margin:16px 0 } .grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(300px,1fr)); gap:16px }
table { width:100%; border-collapse:collapse } td { padding:6px; border-bottom:1px solid #45475a } td:last-child { text-align:right; color:#a6e3a1 }
small { color:#a6adc8 } code { color:#f9e2af }
</style><body><h1>AI work trace</h1><p>Local-only summary. Prompt and response bodies are never displayed.</p>
<div class="cards" id="cards"></div><div class="grid"><section><h2>Services</h2><div id="services"></div></section><section><h2>Log events</h2><div id="events"></div></section><section><h2>Top spans</h2><div id="spans"></div></section><section><h2>Metrics</h2><div id="metrics"></div></section></div>
<p><small>Source: <code id="source"></code> · refreshes every 15 seconds</small></p>
<script>
const escapeHtml = value => String(value).replace(/[&<>"']/g, char => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[char]));
const table = rows => '<table>' + rows.map(([name,count]) => `<tr><td>${escapeHtml(name)}</td><td>${count}</td></tr>`).join('') + '</table>';
async function refresh() { const d=await (await fetch('/api/summary')).json();
 document.querySelector('#source').textContent=d.traceFile;
 document.querySelector('#cards').innerHTML=[['Log records',d.logs],['Spans',d.spans],['Metric definitions',d.metrics],['Sessions',d.sessions],['Stored',`${(d.fileBytes/1024).toFixed(1)} KiB`]].map(([n,v])=>`<div class="card"><small>${n}</small><div class="number">${v}</div></div>`).join('');
 for (const [id, rows] of Object.entries({services:d.services,events:d.events,spans:d.spansByName,metrics:d.metricsByName})) document.querySelector('#'+id).innerHTML=table(rows);
} refresh(); setInterval(refresh,15000);
</script>"""


class Handler(BaseHTTPRequestHandler):
    # Set from --trace-file before the server starts; the module that writes
    # the file is the one that names it.
    trace_file = None

    def do_GET(self):
        path = urlparse(self.path).path
        if path == "/api/summary":
            payload = json.dumps(summary(self.trace_file)).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
        elif path == "/":
            payload = PAGE.encode()
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
        else:
            self.send_error(404)
            return
        self.send_header("Content-Length", str(len(payload)))
        self.end_headers()
        self.wfile.write(payload)

    def log_message(self, *_):
        pass


parser = argparse.ArgumentParser(description="View local AI work telemetry.")
parser.add_argument("--port", type=int, default=4319)
parser.add_argument("--trace-file", type=Path, required=True)
parser.add_argument("--open", action="store_true", help="open the page in a browser")
args = parser.parse_args()
Handler.trace_file = args.trace_file
server = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)
url = f"http://127.0.0.1:{args.port}"
print(f"AI work trace dashboard: {url}")
# The constructor already bound and listened, so the browser cannot arrive
# before the socket is ready to queue it.
if args.open:
    webbrowser.open(url)
try:
    server.serve_forever()
except KeyboardInterrupt:
    pass
