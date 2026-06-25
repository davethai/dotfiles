# Runbook: day-to-day operations & troubleshooting

Operational reference for a machine already set up. For first-time setup see the
[getting-started tutorial](tutorials/getting-started.md).

## Routine operations

### Pull and apply the latest config
```sh
chezmoi update          # git pull + apply; re-runs mise/brew if their files changed
```

### Update tools
```sh
mise upgrade            # CLI tools (both OSes)
brew upgrade            # macOS casks/formulae
```

### Change a config file
```sh
chezmoi edit ~/.zshrc   # edit source; saves + applies
chezmoi diff            # always preview first
```

### Add a tool / app
See [add-a-package](how-to/add-a-package.md).

## Troubleshooting

### "Command not found" after install
mise tools load via shell activation. Restart the shell:
```sh
exec zsh
mise ls                 # confirm the tool is installed
which <tool>            # confirm it's on PATH (should be a mise shim)
```

### A `run_onchange` script didn't re-run
Its content hash is unchanged. Force it:
```sh
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```

### `brew bundle` failed on one item
`brew bundle` continues past failures and reports at the end. Re-run after
fixing; it skips already-installed items. For Mac App Store errors on already
installed apps, keep those `mas` lines commented (see
[manual-app-setup](how-to/manual-app-setup.md)).

### mise can't resolve a tool name
The short name isn't in the registry. Use an explicit backend
(`aqua:`, `npm:`, `pipx:`, `cargo:`) — see the commented examples in
`home/dot_config/mise/config.toml`.

### Dock didn't update / dockutil missing
`dockutil` comes from the Brewfile. Confirm it installed, then re-trigger:
```sh
command -v dockutil
chezmoi apply
```

### Starship prompt not showing
```sh
command -v starship     # installed by mise
mise install -y         # if missing
exec zsh
```
The prompt requires a Nerd Font in your terminal (Ghostty: set in
`~/.config/ghostty/config`; Windows Terminal: set the profile font).

### git commit signing fails
```sh
ssh-add -L                                  # key loaded?
git config --get gpg.ssh.allowedSignersFile  # path correct?
cat ~/.config/git/allowed_signers            # your key listed?
```
Re-run `chezmoi init` to fix the signing-key value if it's wrong.

### hk hook not running
```sh
hk install              # (re)install hooks into the repo
hk --version            # must match the version pinned in hk.pkl's `amends` URL
```

## Health checks
```sh
chezmoi doctor
mise doctor
brew doctor             # macOS
```

## Disaster recovery
The machine is reproducible from this repo. Worst case, re-run the one-liner
from the [tutorial](tutorials/getting-started.md) — `chezmoi apply` is
idempotent and safe to re-run.
