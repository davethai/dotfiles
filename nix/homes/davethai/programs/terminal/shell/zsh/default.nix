{
  imports = [
    ./aliases.nix
    ./plugins.nix
  ];

  programs.zsh = {
    enable = true;
  };
}