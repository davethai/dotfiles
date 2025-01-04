{ pkgs, ...}: {
  imports = [
    ./homebrew
    ./packages
    ./system
    ./fonts.nix
  ];
}