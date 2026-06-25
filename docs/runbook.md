# Runbook: day-to-day operations & troubleshooting

Operational reference for a machine already set up. For first-time setup see the
[getting-started tutorial](tutorials/getting-started.md).

## Routine operations

### Update everything
One command per layer (or just run the `up` alias):
```sh
mise upgrade                  # CLI toolchain
brew update && brew upgrade   # macOS apps (casks) + native CLIs (incl. mise if brew-managed)
zinit update --all            # zsh plugins

# all of the above in one shot:
up
```
`mise self-update` only applies when mise was installed via its own installer
(`curl mise.run`). When mise is package-managed (Homebrew on macOS), `brew
upgrade` keeps it current and `self-update` is a no-op — the `up` alias handles
both cases.

### Change a config file
On this machine (where `~/.dotfiles` is your editable source):
```sh
chezmoi edit ~/.zshrc   # edit source; saves + applies
chezmoi diff            # preview pending changes
chezmoi apply           # write changes to $HOME
```
After editing the **Brewfile** or **mise config**, run `chezmoi apply` (not the
`upgrade` commands) — that re-runs `brew bundle` / `mise install` to pick up
*added* packages. `brew upgrade` / `mise upgrade` only bump versions of things
already installed.

### Pull config changes from another machine
```sh
chezmoi update          # git pull ~/.dotfiles + apply
```
Use this only on a *secondary* machine. On your primary machine you edit the
repo directly and run `chezmoi apply` — `chezmoi update` would pull from origin
and could conflict with uncommitted local edits.

### Add a tool / app
See [add-a-package](how-to/add-a-package.md).

### Add a tool / app
See [add-a-package](how-to/add-a-package.md).

## Convergence, drift & cleanup

This stack is **declarative in intent** but only **convergent where it's safe**.
Know the difference before you prune.

| Layer | Default behavior | Convergent? |
|---|---|---|
| **mise** (CLI tools) | additive (`mise install` only adds) | **Yes, safely** — mise is the complete source of truth for CLI tools |
| **Homebrew** (apps) | additive — `brew bundle` never removes | No by default (deliberately) |

### Why Homebrew is additive (and stays that way)

Nix/Terraform converge to *exactly* the declared state because **everything**
lives in one enclosed store. Homebrew has external state Nix didn't — third-party
taps, transitive dependencies, ad-hoc `brew install`s — and `brew bundle cleanup`
prunes **every** top-level package you didn't declare, bluntly. (The old
nix-darwin setup also ran `homebrew.onActivation.cleanup = "none"` for the same
reason.) So we keep brew additive and never wire cleanup into `chezmoi apply`.

### Pruning mise (safe)
```sh
mise prune --dry-run     # preview orphaned tool versions
mise prune               # remove versions no config references
```
Safe because removing a tool from `mise/config.toml` + `mise prune` only affects
mise-managed tools — nothing else on the system.

### Pruning Homebrew (treat like `terraform plan` → `apply`)
```sh
brew bundle cleanup --file=Brewfile          # ⚠️ Homebrew 6 PROMPTS then proceeds
```
> **Read the list it prints — that list is your plan.** It removes everything not
> in the Brewfile, including bootstrap tools if they aren't declared. Reconcile
> the Brewfile first (add anything worth keeping), *then* run with `--force`.
> mise lives in `~/.local/bin` (its own installer), **outside** brew, so cleanup
> can't remove it — keep it that way.

### Resolving drift (installed but not declared)

When a tool is installed but missing from the Brewfile / mise config, either
**declare** it or **remove** it:
- CLI tool in the mise registry → add to `mise/config.toml`.
- CLI tool *not* in mise (e.g. `terraform`, `infisical`, `process-compose`) →
  add to the `Brewfile` (macOS). Third-party taps are auto-`brew trust`ed by the
  brew script.
- A leftover duplicate (e.g. a brew copy of a mise tool) → `brew uninstall <x>`
  or `mise uninstall <x>` to drop the redundant one.

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

### WSL: `chezmoi init` did nothing / `zsh: command not found`

Don't `git clone` the repo and run `chezmoi init --apply --source ~/.dotfiles` —
chezmoi can treat the local clone oddly and apply nothing, so the bootstrap never
installs zsh. Let chezmoi clone it itself:
```sh
chezmoi init --apply davethai
```
If the bootstrap's `apt` step already failed partway, finish it by hand then apply:
```sh
sudo apt update && sudo apt install -y zsh build-essential curl file unzip ca-certificates chafa
command -v mise >/dev/null || curl -fsSL https://mise.run | sh
chezmoi apply
chsh -s "$(command -v zsh)" && exec zsh
```

### WSL: glyphs are boxes (▯) / wrong background

Those are rendered by the **Windows** terminal, not WSL — install a Nerd Font on
Windows and set it as the terminal font, and set the background to Catppuccin
Mocha `#1e1e2e`. See the [getting-started Windows section](tutorials/getting-started.md#on-windows--manual-wsl-cant-manage-the-host).

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
