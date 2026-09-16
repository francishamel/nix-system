{
  flake.modules.homeManager.darwin =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      grpcEndpoint = "http://127.0.0.1:4317";
      grpcListenAddress = "127.0.0.1:4317";
      httpListenAddress = "127.0.0.1:4318";
      traceDirectory = "${config.home.homeDirectory}/Library/Application Support/ai-work-trace";
      collectorConfig = pkgs.writeText "ai-work-trace-collector.yaml" ''
        receivers:
          otlp:
            protocols:
              grpc:
                endpoint: ${grpcListenAddress}
              http:
                endpoint: ${httpListenAddress}

        exporters:
          file/ai-work-trace:
            path: ${traceDirectory}/otel.jsonl
            format: json
            append: true

        service:
          pipelines:
            logs:
              receivers: [otlp]
              exporters: [file/ai-work-trace]
            metrics:
              receivers: [otlp]
              exporters: [file/ai-work-trace]
            traces:
              receivers: [otlp]
              exporters: [file/ai-work-trace]
      '';
      collector = pkgs.writeShellApplication {
        name = "ai-work-trace-collector";
        text = ''
          mkdir -p ${lib.escapeShellArg traceDirectory}
          exec ${pkgs.opentelemetry-collector-contrib}/bin/otelcol-contrib --config=${collectorConfig}
        '';
      };
      dashboard = pkgs.writeShellApplication {
        name = "ai-work-trace-dashboard";
        runtimeInputs = [ pkgs.python3 ];
        text = ''
          exec python ${./telemetry-dashboard.py} "$@"
        '';
      };
    in
    {
      home.packages = [ dashboard ];

      # Both coding agents export local-only telemetry to this collector.
      programs.claude-code.settings.env = {
        CLAUDE_CODE_ENABLE_TELEMETRY = "1";
        OTEL_LOGS_EXPORTER = "otlp";
        OTEL_METRICS_EXPORTER = "otlp";
        OTEL_TRACES_EXPORTER = "otlp";
        OTEL_EXPORTER_OTLP_PROTOCOL = "grpc";
        OTEL_EXPORTER_OTLP_ENDPOINT = grpcEndpoint;
      };

      programs.codex.settings.otel = {
        environment = "personal";
        log_user_prompt = true;
        exporter.otlp-grpc.endpoint = grpcEndpoint;
        trace_exporter.otlp-grpc.endpoint = grpcEndpoint;
        metrics_exporter.otlp-grpc.endpoint = grpcEndpoint;
      };

      # This user agent provides a local OTLP endpoint. The collector appends
      # raw telemetry locally; no cloud telemetry backend is involved.
      launchd.agents.ai-work-trace = {
        enable = true;
        config = {
          ProgramArguments = [ "${collector}/bin/ai-work-trace-collector" ];
          RunAtLoad = true;
          KeepAlive = true;
          ProcessType = "Background";
          StandardOutPath = "${traceDirectory}/collector.out.log";
          StandardErrorPath = "${traceDirectory}/collector.err.log";
        };
      };
    };
}
