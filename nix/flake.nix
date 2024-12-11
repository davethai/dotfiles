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

  outputs = inputs@{ self, nixpkgs, darwin, homebrew }:
  let
    # ---- SYSTEM SETTINGS ---- #
    system = "aarch64-darwin";

    # ---- USER SETTINGS ---- #
    user = "davethai";
    hostname = "Daves-MacBook-Pro";

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
      specialArgs = {inherit inputs system self user;};

      modules = [ 
        ./modules
        aliasConfiguration
        homebrew.darwinModules.nix-homebrew
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
