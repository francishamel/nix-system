{ config, pkgs, ... }:

{
  home.packages = [ pkgs.glab ];

  xdg.configFile."glab-cli/hm_aliases.yml" = {
    text = ''
      rc: repo clone $1 ${config.home.homeDirectory}/src/glab-cli/$1
    '';
    # HACK: necessary since glab-cli requires the permissions of the file to be 600 and
    # home-manager creates a symlink with 444 permissions.
    onChange = ''
      rm -f ${config.xdg.configHome}/glab-cli/aliases.yml
      cp ${config.xdg.configHome}/glab-cli/hm_aliases.yml ${config.xdg.configHome}/glab-cli/aliases.yml
      chmod 600 ${config.xdg.configHome}/glab-cli/aliases.yml
    '';
  };

  xdg.configFile."glab-cli/hm_config.yml" = {
    text = ''
      git_protocol: ssh
      editor:
      browser:
      glamour_style: dark
      check_update: false
      display_hyperlinks: true
      host: gitlab.com
      no_prompt: false
      hosts:
          gitlab.com:
              api_protocol: https
              api_host: gitlab.com
    '';
    # HACK: necessary since glab-cli requires the permissions of the file to be 600 and
    # home-manager creates a symlink with 444 permissions.
    onChange = ''
      rm -f ${config.xdg.configHome}/glab-cli/config.yml
      cp ${config.xdg.configHome}/glab-cli/hm_config.yml ${config.xdg.configHome}/glab-cli/config.yml
      chmod 600 ${config.xdg.configHome}/glab-cli/config.yml
    '';
  };
}
