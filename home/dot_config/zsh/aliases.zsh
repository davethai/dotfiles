# Aliases. Sourced by ~/.zshrc.

# Preserve alias expansion after sudo (trailing space is intentional).
alias sudo='sudo '

# ── files / navigation ───────────────────────────────────────────────
alias ls='eza -h --git --icons --color=auto --group-directories-first -s extension'
alias ll='eza -lh --git --icons --group-directories-first'
alias la='eza -lah --git --icons --group-directories-first'
alias cat='bat --style=plain'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ── git ──────────────────────────────────────────────────────────────
alias gst='git status'
alias gaa='git add .'
alias gc='git commit'
alias gp='git push'
alias lg='lazygit'

# ── kubernetes ───────────────────────────────────────────────────────
alias k='kubectl'
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'
alias kgp='kubectl get pods'
alias kgsvc='kubectl get services'
alias kgep='kubectl get endpoints'
alias kgns='kubectl get namespaces'
alias kgno='kubectl get nodes'
alias kgpv='kubectl get persistentvolumes'
alias kgpvc='kubectl get persistentvolumeclaims'
alias kgcm='kubectl get configmaps'
alias kgs='kubectl get secrets'
alias kgev='kubectl get events'
alias kgsa='kubectl get serviceaccounts'
alias kgd='kubectl get deploy'
alias kgrs='kubectl get replicasets'
alias kgsts='kubectl get statefulsets'
alias kgds='kubectl get daemonsets'
alias kgj='kubectl get jobs'
alias kgcj='kubectl get cronjobs'
alias kging='kubectl get ingresses'
alias kgnetpol='kubectl get networkpolicies'

# ── misc ─────────────────────────────────────────────────────────────
alias p='podman'
alias a='php artisan'
