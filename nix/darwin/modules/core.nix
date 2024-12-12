{ pkgs, config, system, self, ... }:
{
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
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  programs = {
    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh.enable = true;
    direnv.enable = true;
  };
}