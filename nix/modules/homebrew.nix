{ pkgs, config, ... }: {
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      # 3D Modeling
      "blender"
      # Collaboration
      "discord"
      "microsoft-teams"
      "telegram"
      "zoom"
      # Design
      "figma"
      # Code
      "visual-studio-code"
      # Database
      "pgadmin4"
      "tableplus"
      # Gaming
      "steam"
      # Peripherals
      "logi-options+"
      # Productivity Tools
      "imageoptim"
      "rectangle-pro"
      # Storage
      "dropbox"
      # Security
      "malwarebytes"
      # Video
      "elgato-camera-hub"
      "obs"
      # Other
      "google-chrome"
      "flux"
    ];
    masApps = {
      "Affinity Photo 2" = 1616822987;
      "Affinity Designer 2" = 1616831348;
      "Affinity Publisher 2" = 1606941598;
      "Amazon Kindle" = 302584613;
      "Logic Pro" = 634148309;
    };
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}