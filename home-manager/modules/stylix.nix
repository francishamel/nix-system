{ flake, pkgs, ... }:

{
  imports = [ flake.inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    fonts = {
      monospace = {
        name = "FiraCode Nerd Font";
        package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; });
      };
      sizes.terminal = 14;
    };

    # Disabling VSCode styling because the generated style is not great...
    targets.vscode.enable = false;
  };
}
