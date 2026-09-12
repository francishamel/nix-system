import type { ExtensionAPI, Theme } from "@earendil-works/pi-coding-agent";
import { VERSION } from "@earendil-works/pi-coding-agent";

function compactPath(cwd: string): string {
  const home = process.env.HOME;
  if (home && cwd.startsWith(home)) return `~${cwd.slice(home.length)}`;
  return cwd;
}

function fit(text: string, max: number): string {
  if (max <= 0) return "";
  if (text.length <= max) return text;
  if (max <= 1) return "…";
  return `${text.slice(0, max - 1)}…`;
}

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    if (ctx.mode !== "tui") return;

    const cwd = compactPath(ctx.cwd);
    const model = ctx.model
      ? `${ctx.model.provider}/${ctx.model.id}`
      : "coding agent";

    ctx.ui.setHeader((_tui, theme: Theme) => ({
      render(width: number): string[] {
        const accent = (text: string) => theme.fg("accent", text);
        const muted = (text: string) => theme.fg("muted", text);
        const dim = (text: string) => theme.fg("dim", text);
        const textWidth = Math.max(8, width - 15);

        const logo = ["██████  ", "██  ██  ", "████  ██", "██    ██"].map(
          accent,
        );

        return [
          "",
          ` ${logo[0]}  ${theme.bold("Pi")} ${dim(`v${VERSION}`)}`,
          ` ${logo[1]}  ${muted(fit(model, textWidth))}`,
          ` ${logo[2]}  ${dim(fit(cwd, textWidth))}`,
          ` ${logo[3]}`,
          "",
        ];
      },
      invalidate() {},
    }));
  });
}
