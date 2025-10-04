{ ... }: {
  homebrew = {
    taps = [
      "argoproj/tap"
      "eranif/codelite"
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
      "codelite-official"
    ];
    masApps = {
      "Amazon Kindle" = 302584613;
      "Logic Pro" = 634148309;
    };
  };
}