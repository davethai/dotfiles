# NVM
export NVM_DIR="$HOME/.nvm"

if command -v brew >/dev/null 2>&1; then
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
  [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \
    . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
fi
