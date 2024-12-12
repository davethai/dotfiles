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

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, homebrew, home-manager }:
  let
    # ---- SYSTEM SETTINGS ---- #
    system = "aarch64-darwin";
    hostname = "Daves-MacBook-Pro";
    
    # ---- USER SETTINGS ---- #
    user = "davethai";
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Daves-MacBook-Pro
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      specialArgs = {inherit inputs system self user;};
      modules = [ 
        ./darwin
        homebrew.darwinModules.nix-homebrew
        home-manager.darwinModule
        {
          users.users.${user}.home = "/Users/davethai";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {inherit inputs;};
            
            users.${user} = {...}: with inputs; {
              imports = [
                ./homemanager
              ];
              home.stateVersion = "24.05";
            };
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
