{
  description = "Dave Thai Nix monorepo";

  inputs = {
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
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, homebrew}: {
    darwinConfigurations = {
      macbook-pro-m1-max-16 = darwin.lib.darwinSystem {
        specialArgs = {inherit self inputs home-manager homebrew;
         user = "davethai";
        };
        modules = [ 
          ./hosts/macbook-pro-m1-max-16.nix
        ];  
      };
    };

    # NixOS + WSL 2
    nixosConfiguration = {
      asus-tuf-gaming = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit self inputs home-manager;
          user = "davethai";
        };
        modules = [
          ./hosts/asus-tuf-gaming.nix
        ];
      };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations.macbook-pro-m1-max-16.pkgs;
    nixosPackages = self.nixosConfiguration.asus-tuf-gaming.pkgs;
  };
}
