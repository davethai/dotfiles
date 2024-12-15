{
  imports = [
    ./aliases.nix
    # ./init.nix
    ./plugins.nix
  ];

  programs.zsh = {
    enable = true;
  };
}