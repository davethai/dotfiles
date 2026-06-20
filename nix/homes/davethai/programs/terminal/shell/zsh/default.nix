{
  imports = [
    ./aliases.nix
    ./plugins.nix
  ];

  programs.zsh = {
    enable = true;

    # macOS Terminal/iTerm/ghostty spawn login shells, and home-manager's
    # auto-injected .zshenv guards hm-session-vars.sh behind `! -o login`.
    # Sourcing here in .zprofile ensures JAVA_HOME et al. load for login shells too.
    profileExtra = ''
      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';

    initContent = ''
      source ${./rc/env.zsh}
      source ${./rc/binds.zsh}
      source ${./rc/comp.zsh}
      source ${./rc/fzf.tab.zsh}

      # Activate mise so per-project toolchains (mise.toml: node, just, hk, ...)
      # land on PATH. mise itself is installed via Homebrew (see apps.nix); the
      # guard keeps the shell working if it isn't present.
      if command -v mise >/dev/null; then
        eval "$(mise activate zsh)"
      fi
    '';
  };
}