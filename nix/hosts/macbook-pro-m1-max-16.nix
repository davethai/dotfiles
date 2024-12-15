{ home-manager, homebrew, user, ...}: {
  imports = [
    ../system/shared
    ../system/darwin
    home-manager.darwinModules.default
    ../home-manager
    ../home-manager/darwin
    homebrew.darwinModules.nix-homebrew
  ];
}