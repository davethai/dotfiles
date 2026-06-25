# Brewfile — macOS only.
#
# Responsibility: GUI apps (casks), Mac App Store (mas), and a handful of
# mac-native CLIs that are system-level or simply more idiomatic via Homebrew.
#
# Cross-platform CLI dev tools do NOT live here — they live in mise
# (~/.config/mise/config.toml) so macOS and WSL/Ubuntu share one source.
#
# Applied automatically by chezmoi (run_onchange_after_30-brew). Manually:
#   brew bundle --file=Brewfile

# ── taps ────────────────────────────────────────────────────────────
# Third-party taps are trusted by the chezmoi brew script (Homebrew 6 requires
# trusting non-core taps before it will load their formulae).
tap "slp/krunkit"        # krunkit: podman machine provider (Apple silicon)
tap "dbt-labs/dbt-cli"   # dbt
tap "hashicorp/tap"      # terraform
tap "argoproj/tap"       # kubectl-argo-rollouts
tap "infisical/get-cli"  # infisical

# ── mac-native CLI (system libs / brew-idiomatic) ───────────────────
brew "mas"               # Mac App Store CLI
brew "dockutil"          # declarative Dock (used by chezmoi dock script)
brew "btop"              # system monitor (aqua/mise pkg is Linux-only)
brew "chafa"             # terminal image renderer (zsh greeter logo)
brew "tmux"
brew "ffmpeg"
brew "ollama"
brew "podman"
brew "krunkit"
brew "skopeo"
brew "dbt"

# ── devops CLIs not in the mise registry (so they live here, macOS) ─
brew "terraform"               # hashicorp/tap
brew "kubectl-argo-rollouts"   # argoproj/tap
brew "infisical"               # infisical/get-cli

# ── fonts ───────────────────────────────────────────────────────────
cask "font-jetbrains-mono-nerd-font"   # Ghostty
cask "font-fira-code-nerd-font"        # VS Code editor + terminal

# ── GUI casks ───────────────────────────────────────────────────────
# browsers
cask "google-chrome"
cask "brave-browser"
# terminal / editors / IDEs
cask "ghostty"
cask "visual-studio-code"
cask "cursor"
cask "android-studio"
cask "temurin@21"            # JDK (JAVA_HOME points here)
# dev / containers
cask "orbstack"
cask "podman-desktop"
cask "tableplus"
cask "claude-code"
cask "tailscale-app"
cask "herd"                  # Laravel Herd: PHP versions + Composer + nginx + *.test
# design / media
cask "figma"
cask "blender"
cask "obs"
cask "imageoptim"
cask "elgato-camera-hub"
# comms
cask "discord"
cask "microsoft-teams"
cask "telegram"
cask "zoom"
cask "signal"
# utilities
cask "rectangle-pro"
cask "logi-options+"
cask "dropbox"
cask "malwarebytes"
cask "flux-app"
# gaming
cask "steam"

# ── Mac App Store ───────────────────────────────────────────────────
# mas errors when an app is already installed; uncomment on a fresh machine.
# mas "Kindle",    id: 602584613
# mas "Logic Pro", id: 634148309
