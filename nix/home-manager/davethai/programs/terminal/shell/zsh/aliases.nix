{pkgs, lib, ...}: let
  inherit (lib.meta) getExe;
  inherit (pkgs) bat eza;
in {
  programs.zsh.shellAliases = {
    # make sudo use aliases
    sudo = "sudo ";

    # quality of life aliases
    cat = "${getExe bat} --style=plain";
    ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";

    # quick navigation
    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";
    "......" = "cd ../../../../../";
  };
}