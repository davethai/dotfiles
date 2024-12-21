{ pkgs, agenix, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    (agenix.packages.${pkgs.system}.default)
  ];
}