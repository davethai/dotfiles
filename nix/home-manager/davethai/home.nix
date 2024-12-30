{ config, ...}:
let
  packages = import ./packages { inherit pkgs config; };
  programs = import ./programs { inherit pkgs config; };
in {
  imports = [
    ./packages
    ./programs
  ];

  home = {
    stateVersion = "23.05";
    username = "davethai";
  } // packages // programs;
}
