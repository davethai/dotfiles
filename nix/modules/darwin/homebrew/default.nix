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
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}