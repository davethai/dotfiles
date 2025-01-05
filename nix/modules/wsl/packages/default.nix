{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
      nix-ld
    ];
}