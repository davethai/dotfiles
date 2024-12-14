{ home-manager, homebrew, user, ...}: {
  imports = [
    ../system/shared
    ../system/darwin
    home-manager.darwinModules.default
    ../home-manager
    ../home-manager/darwin
    ../home-manager/${user}
    homebrew.darwinModules.nix-homebrew
  ];
}