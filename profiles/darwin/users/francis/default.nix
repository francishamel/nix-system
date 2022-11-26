{ ... }:

{
  modules.user-manager.users."francis" = {
    home = ../../../../configs/home-manager;
    uid = 501;
  };
}
