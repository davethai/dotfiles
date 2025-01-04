{ self, config, pkgs, ... }:
let
  controlcenter = import ./control-center.nix { inherit pkgs config; };
  dock = import ./dock.nix { inherit pkgs config; };
  finder = import ./finder.nix { inherit pkgs config; };
in
{ 
  imports = [
    ./nix/services.nix
  ];

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;

    defaults = {
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
      };
    } // controlcenter // dock // finder;
  };
}