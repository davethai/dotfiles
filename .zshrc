# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
neofetch | lolcat
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew apps available on PATH
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 1) Plugin Manager - Zinit (pinned for supply-chain safety; bump deliberately)
ZINIT_PIN="v3.14.0"
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone --depth 1 --branch "$ZINIT_PIN" https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
elif [ "$(git -C "$ZINIT_HOME" describe --tags --exact-match HEAD 2>/dev/null)" != "$ZINIT_PIN" ]; then
   git -C "$ZINIT_HOME" fetch --tags --depth 1 origin "refs/tags/$ZINIT_PIN:refs/tags/$ZINIT_PIN" >/dev/null 2>&1
   git -C "$ZINIT_HOME" checkout --quiet "$ZINIT_PIN"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# 2) Prompt - Powerlevel10k 
zinit ice depth=1; zinit light romkatv/powerlevel10k

# 3) Plugins
# zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# 4) Snippets
zinit snippet OMZP::git

# 5) Plugin Configuration
# Autoload completions
autoload -U compinit && compinit
zinit cdreplay -q
# History persist between sessions
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 6) Keybindings (emacs mode)
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# 7) Aliases
alias ls='ls --color'
alias c='clear'
alias k='kubectl'


# 8) Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"
