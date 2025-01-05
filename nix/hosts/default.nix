{ withSystem, inputs, self, lib, ...}: {

  flake = {
    nixosConfigurations = {
      # Dewgong US-CT-B01-F01-R1-D-WS-002
      # Asus Tuf Gaming Motherboard
      # CPU - AMD Ryzen 9 3900X 12-core
      # GPU - Nvidia GeForce RTX 2070 Super 8 GB GDDR6 PCI Express 3.0
      # RAM - G.SKILL Trident Z Neo Series 32GB
      dewgong = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit self inputs;};
        modules = [
          ../modules/shared
          inputs.nixos-wsl.nixosModules.default
          ../modules/wsl
          ./wsl/dewgong/host.nix
          inputs.agenix.nixosModules.default
          inputs.home-manager.nixosModules.default
          ../homes
          ../homes/davethai/wsl.nix
        ];
      };
    };

    darwinConfigurations = {
      # Rhydon L-WS-001
      # Apple MacBook Pro M1 Max 16" (2021)
      # RAM - 32GB
      rhydon = inputs.darwin.lib.darwinSystem {
        specialArgs = {inherit self inputs;};
        modules = [
          ../modules/shared
          ../modules/darwin
          ./darwin/rhyhorn/host.nix
          inputs.agenix.darwinModules.default
          inputs.homebrew.darwinModules.nix-homebrew
          inputs.home-manager.darwinModules.default
          ../homes
          ../homes/davethai/darwin.nix
        ];
      };
    };
  };
}
