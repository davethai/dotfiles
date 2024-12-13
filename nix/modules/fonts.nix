{config, pkgs, lib, ...}: let
  defaultFonts =  with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.symbols-only  #This one
  ];
in {
  options.extraFonts = lib.mkOption {
    type = lib.types.listOf lib.str;
    default = [];
    description = "Additional fonts to be installed along with default fonts.";
  };

  config.fonts.packages = defaultFonts ++ config.extraFonts;
}