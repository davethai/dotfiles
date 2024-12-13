{ self, system, config, pkgs, ... }:
let
  controlcenter = import ./control-center.nix { inherit pkgs config; };
  dock = import ./dock.nix { inherit pkgs config; };
  finder = import ./finder.nix { inherit pkgs config; };
in
{
  imports = [
    ./programs.nix
    ./services.nix
    ./homebrew
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  
  nixpkgs = {
    config.allowUnfree = true;
    # The platform the configuration will be used on.
    hostPlatform = system;
  };

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