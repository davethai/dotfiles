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
    user = "davethai";
    hostname = "Daves-MacBook-Pro";
    system = "aarch64-darwin";

    coreConfiguraton = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
            
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
      nixpkgs.hostPlatform = system;

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;

      # Enable direnv
      programs.direnv.enable = true;
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
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs user;};

      modules = [ 
        coreConfiguraton
        ./modules
        aliasConfiguration
        nix-homebrew.darwinModules.nix-homebrew
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
