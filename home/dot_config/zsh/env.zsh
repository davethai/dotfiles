# Environment variables. Shared — sourced by ~/.zshrc AND ~/.bashrc.
# Keep bash+zsh compatible (no zsh-only syntax).

export EDITOR=nvim
export VISUAL=nvim

# JDK (macOS, Temurin 21 via Homebrew cask)
if [[ "$OSTYPE" == darwin* ]]; then
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home"
fi

# fzf uses fd for fast, .gitignore-aware listings
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Podman → Docker socket compatibility (when a podman machine is running)
if command -v podman &>/dev/null; then
  _sock="$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}' 2>/dev/null)"
  [[ -n "$_sock" ]] && export DOCKER_HOST="unix://${_sock}"
  unset _sock
fi
