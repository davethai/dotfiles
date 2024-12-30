{pkgs,...}: {
  home-manager.home.packages = with pkgs; [
    btop
  ];
}
