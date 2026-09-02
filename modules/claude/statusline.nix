{ ... }:
{
  # Claude Code's status line is a command: it gets session JSON on stdin and
  # its stdout becomes the line. Starship 1.26 understands that JSON itself
  # (`starship statusline claude-code`), which gives us the `claude_model`,
  # `claude_context` and `claude_cost` modules for free. The `claude` profile
  # in modules/starship/starship.toml picks which modules appear, so the status
  # line and the shell prompt share one set of symbols and colours.
  flake.modules.homeManager.base =
    { lib, pkgs, ... }:
    let
      statusline = pkgs.writeShellApplication {
        name = "claude-statusline";
        runtimeInputs = [
          pkgs.jq
          pkgs.starship
        ];
        text = ''
          input=$(cat)

          # Starship renders for its own working directory, not for anything in
          # the JSON, and custom modules run their commands there too. Move to
          # the session directory so both see the right repo or worktree.
          cd "$(jq -r '.workspace.current_dir' <<<"$input")"

          # STARSHIP_SHELL is cleared on purpose. Set, starship wraps colours in
          # zsh's %{ %} or bash's \[ \] escapes, which the status line prints
          # literally. Cleared, it emits raw ANSI.
          prompt=$(printf '%s' "$input" \
            | STARSHIP_SHELL="" starship statusline claude-code --profile claude)

          # `add_newline` puts a blank line before the prompt. Drop it.
          printf '%s' "''${prompt#$'\n'}"
        '';
      };
    in
    {
      programs.claude-code.settings.statusLine = {
        type = "command";
        command = lib.getExe statusline;
        padding = 0;
      };
    };
}
