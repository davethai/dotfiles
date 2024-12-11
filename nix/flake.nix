{
  description = "Dave Thai nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, darwin, nixpkgs, homebrew }:
  let
    user = "davethai";
    hostname = "Daves-MacBook-Pro";
    system = "aarch64-darwin";

    coreConfiguraton = { pkgs, config, ... }: {
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
    };

    aliasConfiguration = { pkgs, config, ... }: {
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
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Daves-MacBook-Pro
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      specialArgs = {inherit inputs self user;};

      modules = [ 
        coreConfiguraton
        ./modules
        aliasConfiguration
        homebrew.darwinModules.nix-homebrew
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
