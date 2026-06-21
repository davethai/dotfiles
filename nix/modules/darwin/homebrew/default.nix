{ pkgs, config, ... }: {
  imports = [ ./apps.nix ];

  nix-homebrew = {
    enable = true;
    # Apple Silicon Only
    enableRosetta = true;
    # User owning the Homebrew prefix
    user = "davethai";
  };

  homebrew = {
    enable = true;
    onActivation = {
      # nix-darwin still emits the removed `--force-cleanup` flag, which
      # Homebrew 6.x rejects. Keep cleanup off until upstream emits `--cleanup`.
      cleanup = "none"; # was "zap"
      autoUpdate = true;
      upgrade = true;
    };
  };
}