{user, ...}: {
  users.users.${user}.home = "/home/${user}";
  home-manager.users.${user}.home.homeDirectory = "/home/${user}";
}