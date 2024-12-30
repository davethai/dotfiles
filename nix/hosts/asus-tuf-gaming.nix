{home-manager, user, ...}: {
  imports = [
    ../system/shared
    ../system/linux
    home-manager.nixosModules.default
    ../home-manager
  ];
}
