{ ... }:
let
  user = "francis";
in
{
  modules.user-manager.users."${user}" = {
    home = ../../../../configs/home-manager/personal.nix;
    uid = 501;
  };

  # TODO: encapsulate this in the user-manager module
  users.knownUsers = [ "${user}" ];
}
