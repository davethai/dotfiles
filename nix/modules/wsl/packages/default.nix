{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.nix-ld = {
    enable = true;
  };
}
