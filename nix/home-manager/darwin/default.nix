{user, ...}: {
  users.users.${user}.home = "/Users/${user}";
  home-manager.users.${user}.home.homeDirectory = "/Users/${user}";
}