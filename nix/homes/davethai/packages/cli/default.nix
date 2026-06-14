{pkgs,...}: {
  home.packages = with pkgs; [
    btop
    lefthook
    trufflehog
  ];
}