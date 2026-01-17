{ ... }: {
  homebrew = {
    taps = [
      "argoproj/tap"
      "slp/krunkit"
    ];
    brews = [
      "mas"
      "cdktf"
      "terraform"
      "podman"
      "kubernetes-cli"
      "k9s"
      "kind"
      "helm"
      "tmux"
      "argocd"
      "argocd-autopilot"
      "kubectl-argo-rollouts"
      "trivy"
      "cosign"
      "krunkit"
      "python@3.12"
      "python@3.14"
      "uv"
      "pnpm"
      "nvm"
    ];
    casks = [
      "blender"
      "discord"
      "microsoft-teams"
      "telegram"
      "zoom"
      "figma"
      "visual-studio-code"
      "pgadmin4"
      "tableplus"
      "steam"
      "logi-options+"
      "imageoptim"
      "rectangle-pro"
      "dropbox"
      "malwarebytes"
      "elgato-camera-hub"
      "obs"
      "google-chrome"
      "brave-browser"
      "signal"
      "flux"
      "ghostty"
      "podman-desktop"
      "claude-code"
      "flutter"
      "android-studio"
    ];
    masApps = {
      "Amazon Kindle" = 302584613;
      "Logic Pro" = 634148309;
    };
  };

}