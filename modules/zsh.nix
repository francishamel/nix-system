{ config, lib, ... }:
let
  order = config.flake.meta.zsh.initOrder;
  username = config.flake.meta.user.username;
in
{
  options.flake.meta.zsh.initOrder = lib.mkOption {
    description = ''
      Named slots for `programs.zsh.initContent`. Every module that writes to
      initContent picks one with `lib.mkOrder`, so the generated .zshrc stops
      depending on the order import-tree happens to read files in.

      The numbers interleave with home-manager's own zsh module, which sets PATH
      and fpath at 510-540, runs compinit at 570, sources zsh plugins at 900,
      and loads zsh-syntax-highlighting at 1200.
    '';
    type = lib.types.submodule {
      options = {
        path = lib.mkOption {
          type = lib.types.int;
          description = "Sets PATH. Runs before anything that reads it.";
        };

        fpath = lib.mkOption {
          type = lib.types.int;
          description = "Adds to fpath. compinit must see the entry.";
        };

        interactive = lib.mkOption {
          type = lib.types.int;
          description = ''
            Widgets, keybindings, zstyle, shell hooks. compinit has run and the
            plugins are sourced; syntax highlighting has not yet read the widgets.
          '';
        };

        aliases = lib.mkOption {
          type = lib.types.int;
          description = "Aliases. Nothing reads them during startup, so they come last.";
        };
      };
    };
  };

  config.flake = {
    meta.zsh.initOrder = {
      path = 500;
      fpath = 550;
      interactive = 1000;
      aliases = 1050;
    };

    modules = {
      darwin.base =
        { pkgs, ... }:
        {
          programs.zsh.enable = true;
          users.users.${username}.shell = pkgs.zsh;
        };

      homeManager = {
        base =
          { config, ... }:
          {
            programs.zsh = {
              enable = true;
              dotDir = "${config.xdg.configHome}/zsh";
              historySubstringSearch.enable = true;
              syntaxHighlighting.enable = true;
              initContent = lib.mkOrder order.interactive ''
                # Load edit-command-line widget
                autoload -Uz edit-command-line
                zle -N edit-command-line
                bindkey '^x^e' edit-command-line

                # Bind magic-space
                bindkey ' ' magic-space

                # Enable zmv (used to rename multiple files easily)
                autoload zmv
              '';
            };
          };

        darwin = {
          # Disable last login message
          home.file.".hushlogin".text = "";

          programs.zsh.initContent = lib.mkOrder order.aliases ''
            # Global aliases
            alias -g C='| pbcopy'
            alias -g OR='op run -- '
          '';
        };
      };
    };
  };
}
