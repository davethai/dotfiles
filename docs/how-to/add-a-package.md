# How-to: Add (or remove) a package

First decide **what kind** of thing it is — that determines where it goes.

| It's a… | Goes in | Applies to |
|---|---|---|
| CLI tool or language runtime | `home/dot_config/mise/config.toml` | macOS + Linux |
| macOS GUI app (cask) | `Brewfile` | macOS |
| Mac App Store app | `Brewfile` (`mas` line) | macOS |
| mac-native CLI (system lib) | `Brewfile` | macOS |
| Linux base system package | `home/.chezmoiscripts/run_once_before_10-bootstrap.sh.tmpl` | Linux |

## Add a CLI tool (most common)

1. Find the tool name in the [mise registry](https://mise.jdx.dev/registry.html).
2. Add it under `[tools]` in `home/dot_config/mise/config.toml`:
   ```toml
   ripgrep = "latest"
   ```
   Not a single-word registry entry? Use a backend explicitly:
   ```toml
   "aqua:owner/repo" = "latest"
   "npm:some-cli"    = "latest"
   "pipx:some-tool"  = "latest"
   ```
3. Apply:
   ```sh
   chezmoi apply        # writes the config, then runs `mise install`
   ```
   The mise script re-runs automatically because the config's hash changed.

## Add a macOS GUI app

1. Find the cask: `brew search --cask <name>`.
2. Add `cask "<name>"` to the `Brewfile` (under the right comment group).
3. `chezmoi apply` → `brew bundle` re-runs (Brewfile hash changed).

## Add a Mac App Store app

1. Get its id: `mas search <name>`.
2. Add `mas "<Name>", id: <id>` to the `Brewfile`.
3. `chezmoi apply`.

## Remove a package

Delete the line and `chezmoi apply`. Note: `brew bundle` does **not** uninstall
removed casks unless you run `brew bundle cleanup --file=Brewfile` manually
(intentionally conservative — review before zapping apps).

## Test before committing

```sh
chezmoi diff         # preview file + script changes
chezmoi apply -v     # apply with verbose output
```
