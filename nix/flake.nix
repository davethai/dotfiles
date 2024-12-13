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
      url = "github:nix-community/home-manager";
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
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {inherit inputs system self user;};
      modules = [ 
        ./darwin/os
        homebrew.darwinModules.nix-homebrew
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.${hostname}.pkgs;
  };
}
