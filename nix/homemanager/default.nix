{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules
  ];

  home = {
    packages = with pkgs; [
      neovim

    ];
  };

  programs = {
    home-manager.enable = true;

    bat.enable = true;
    zoxide.enable = true;
    eza.enable = true;
  };
}