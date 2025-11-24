{
  flake.modules.homeManager = {
    base =
      { config, ... }:
      {
        programs.zsh = {
          enable = true;
          dotDir = "${config.xdg.configHome}/zsh";
          historySubstringSearch.enable = true;
        };
      };
    darwin = {
      # Disable last login message
      home.file.".hushlogin".text = "";
    };
    darwinAarch64 = {
      # Brew installation changed on Darwin ARM
      programs.zsh.initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };
}
