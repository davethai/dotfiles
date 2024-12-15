{pkgs, lib, ...}: let
  inherit (lib.meta) getExe;
  inherit (pkgs) bat;
in {
  programs.zsh.shellAliases = {
    # make sudo use aliases
    sudo = "sudo ";

    # quality of life aliases
    cat = "${getExe bat} --style=plain";
  };
}