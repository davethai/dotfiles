{ pkgs, ... }: {
  imports = [
    ./packages
    ./programs
  ];

  users.users.davethai.isNormalUser = true;
  users.users.davethai.group = "davethai";
  users.users.davethai.shell = pkgs.zsh;
  users.groups.davethai = {};

  system.stateVersion = "24.05";
  wsl = {
    enable = true;
    defaultUser = "davethai";
  };
}