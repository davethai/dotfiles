{ self, config, pkgs, ... }: {

  nixpkgs.hostPlatform = "x86_64-linux";

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };
}
