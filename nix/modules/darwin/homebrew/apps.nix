{ ... }: {
  homebrew = {
    taps = [
      "argoproj/tap"
      "slp/krunkit"
      "f1bonacc1/tap"
      "hashicorp/tap"
    ];
    brews = [
      "mas"
      "cdktf"
      "podman"
      "krunkit"
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
      "python@3.14"
      "uv"
      "pnpm"
      "nvm"
      "just"
      "ollama"
      "ffmpeg"
      "gh"
      "hashicorp/tap/terraform"
      "f1bonacc1/tap/process-compose"
      "skopeo"
      "rust"
    ];
    casks = [
      "blender"
      "discord"
      "microsoft-teams"
      "telegram"
      "zoom"
      "figma"
      "visual-studio-code"
      "cursor"
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
      "flux-app"
      "ghostty"
      "podman-desktop"
      "claude-code"
      "flutter"
      "android-studio"
      "spokenly"

    ];
    masApps = {
      # "Amazon Kindle" = 302584613; # already installed, mas fails on reinstall
      # "Logic Pro" = 634148309; # already installed, mas fails on reinstall
    };
  };

}