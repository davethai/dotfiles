{
  description = "Dave Thai nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          # Mac Requirement
          pkgs.mkalias
          # Terminal emulator
          pkgs.neofetch
          pkgs.lolcat
          pkgs.fzf
          pkgs.zoxide
          # General
          pkgs.git
          pkgs.stow
        ];
      
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
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono

        nerd-fonts.symbols-only  #This one
      ];

      # Mac Alias - Nix GUI apps show in Spotlight search
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';
      
      system.defaults = {
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        dock = {
          autohide = true;
          autohide-delay = 0.0;
          show-recents = false;
          persistent-apps = [
            "/System/Applications/Messages.app"
            "/System/Applications/Notes.app"
            "/Applications/Google Chrome.app"
            "/Applications/Visual Studio Code.app"
            "/Applications/Discord.app"
            "/Applications/Affinity Photo 2.app"
            "/Applications/Affinity Designer 2.app"
          ];
        };
        finder = {
          FXPreferredViewStyle = "icnv";
        };
        controlcenter = {
          Bluetooth = true;
          BatteryShowPercentage = true;
        };
      };
      
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;

      # Enable direnv
      programs.direnv.enable = true;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Daves-MacBook-Pro
    darwinConfigurations."Daves-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "davethai";
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Daves-MacBook-Pro".pkgs;
  };
}
