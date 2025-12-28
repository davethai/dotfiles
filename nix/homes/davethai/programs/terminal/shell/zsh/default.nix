{
  imports = [
    ./aliases.nix
    ./plugins.nix
  ];

  programs.zsh = {
    enable = true;

    initContent = ''
      source ${./rc/env.zsh}
      source ${./rc/binds.zsh}
      source ${./rc/comp.zsh}
      source ${./rc/fzf.tab.zsh}
    '';
  };
}