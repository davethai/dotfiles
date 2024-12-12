{ config, pkgs, ... }:
let
  controlcenter = import ./controlcenter.nix { inherit pkgs config; };
  dock = import ./dock.nix { inherit pkgs config; };
  finder = import ./finder.nix { inherit pkgs config; };
in
{
  system.defaults = {
    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
    };
  } // controlcenter // dock // finder;
}