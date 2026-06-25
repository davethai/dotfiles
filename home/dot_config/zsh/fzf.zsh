# fzf-tab previews. Sourced by ~/.zshrc.

# Preview directory contents when completing cd / zoxide.
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
# Switch completion groups with < and >.
zstyle ':fzf-tab:*' switch-group '<' '>'
