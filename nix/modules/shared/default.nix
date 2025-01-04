{ pkgs, ...}: {
  imports = [
    ./packages
    ./system
    ./fonts.nix
  ];
}