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

# Podman → Docker socket compatibility (when a podman machine is running). The
# default machine's API socket has a fixed path under $TMPDIR, so testing for it
# costs nothing, where `podman machine inspect` stalls every new shell whenever
# the machine's management API hangs.
_sock="${TMPDIR%/}/podman/podman-machine-default-api.sock"
[[ -S "$_sock" ]] && export DOCKER_HOST="unix://${_sock}"
unset _sock
