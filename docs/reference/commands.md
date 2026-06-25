# Reference: Commands cheatsheet

## chezmoi

| Command | Does |
|---|---|
| `chezmoi diff` | Preview pending changes to files **and** scripts |
| `chezmoi apply` | Render + write files, run provisioning scripts (idempotent) |
| `chezmoi apply -v` | …with verbose output |
| `chezmoi edit <target>` | Edit the source of a managed file |
| `chezmoi add <path>` | Import an existing file into the source |
| `chezmoi cd` | Open a shell in the source dir |
| `chezmoi update` | `git pull` the source, then `apply` |
| `chezmoi init` | Re-run the prompts (regenerates `chezmoi.toml`) |
| `chezmoi doctor` | Diagnose chezmoi setup |
| `chezmoi state delete-bucket --bucket=scriptState` | Forget `run_onchange`/`run_once` hashes (force re-run) |

## mise

| Command | Does |
|---|---|
| `mise install` | Install everything in the config |
| `mise ls` | List installed tools + versions |
| `mise use -g <tool>@<ver>` | Add/pin a global tool (writes to global config) |
| `mise outdated` | Show upgradable tools |
| `mise upgrade` | Upgrade tools within their version constraints |
| `mise doctor` | Diagnose mise setup |
| `mise registry` | List resolvable tool names |

## Homebrew (macOS)

| Command | Does |
|---|---|
| `brew bundle --file=Brewfile` | Install everything in the Brewfile |
| `brew bundle check --file=Brewfile` | Report what's missing |
| `brew bundle cleanup --file=Brewfile` | List (or `--force` remove) anything not in the Brewfile |

## hk

| Command | Does |
|---|---|
| `hk install` | Install this repo's git hooks |
| `hk check` | Run check steps manually |
| `hk run pre-commit` | Run the pre-commit hook on demand |

## Update everything (routine)

```sh
mise upgrade                  # CLI toolchain
brew update && brew upgrade   # macOS apps + native CLIs (incl. brew-managed mise)
zinit update --all            # zsh plugins
```

Or just the `up` alias (defined in `zsh/aliases.zsh`), which runs all three.

Config changes are separate: edit the repo, then `chezmoi apply`. See the
[runbook](../runbook.md#routine-operations) for the `apply` vs `update` distinction.
