{ config, pkgs, lib, system, ... }:{
  # imports = [
  #   ./packages
  #   ./programs
  # ];

  home = {
    stateVersion = "23.05";
    username = "davethai";
    homeDirectory = "/Users/davethai";
  };
}