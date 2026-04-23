# NVM
export NVM_DIR="$HOME/.nvm"

if command -v brew >/dev/null 2>&1; then
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
  [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \
    . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
fi

# Podman - set Docker compatibility socket
if command -v podman >/dev/null 2>&1; then
  export DOCKER_HOST="unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"
fi
