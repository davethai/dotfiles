{ ... }: {
  # imports = [
  #   ./users
  # ];

  users.users.davethai.isNormalUser = true;
  users.users.davethai.group = "davethai";
  users.groups.davethai = {};

  system.stateVersion = "24.05";
  wsl = {
    enable = true;
    defaultUser = "davethai";
  };
}