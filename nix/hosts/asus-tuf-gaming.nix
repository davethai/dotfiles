{home-manager, user, ...}: {
  imports = [
    ../system/shared
    ../system/darwin
    home-manager.nixosModules.default
    ../home-manager
    ../home-manager/linux
    ../home-manager/${user}/home.nix
  ];
}
