# Completion styling. Sourced by ~/.zshrc.

# Case-insensitive matching.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Color completion listings using LS_COLORS.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# fzf-tab handles the menu, so disable zsh's own menu.
zstyle ':completion:*' menu no
