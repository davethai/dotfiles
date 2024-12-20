{
  description = "Dave Thai Nix monorepo";

  inputs = {
    # systems.url = "github:nix-systems/default";
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        darwin.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, homebrew, agenix }: {
    darwinConfigurations = {
      macbook-pro-m1-max-16 = darwin.lib.darwinSystem {
        specialArgs = {inherit self inputs home-manager homebrew agenix;
         user = "davethai";
        };
        modules = [ 
          ./hosts/macbook-pro-m1-max-16.nix
          agenix.darwinModules.default
        ];  
      };
    };

    # NixOS + WSL 2
    nixosConfiguration = {
      asus-tuf-gaming = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit self inputs home-manager agenix;
          user = "davethai";
        };
        modules = [
          ./hosts/asus-tuf-gaming.nix
          agenix.nixosModules.default
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.macbook-pro-m1-max-16.pkgs;
    nixosPackages = self.nixosConfiguration.asus-tuf-gaming.pkgs;
  };
}
