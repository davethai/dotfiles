# dotfiles

Declarative, cross-platform machine setup for **macOS** and **WSL/Ubuntu**.

One command clones this repo, installs every tool, and renders every config
file into place. The same source drives both operating systems; OS-specific
behaviour is handled explicitly, not by accident.

```sh
# macOS or WSL/Ubuntu — fresh machine, one line:
sh -c "$(curl -fsSL https://chezmoi.io/get)" -- init --apply davethai
```

> Replace `davethai` with this repo's owner if you forked it. The command
> installs `chezmoi`, clones the repo, prompts for your git identity, then
> bootstraps the whole machine. See [docs/tutorials/getting-started.md](docs/tutorials/getting-started.md)
> for the guided walkthrough.

---

## Philosophy

Every layer owns **exactly one** responsibility, and lives in the tool that is
*idiomatic* for that job — not whatever happens to be installed.

> **chezmoi** places your files · **mise** installs your tools · **Homebrew**
> installs Mac apps · **apt** bootstraps Linux. Everything else is *config* that
> those four manage.

| Layer | Tool | Owns | Config | OS |
|---|---|---|---|---|
| Dotfile sync | **chezmoi** | Renders/syncs config into `$HOME`, templating, per-machine values | this repo + `home/.chezmoi.toml.tmpl` | both |
| CLI tools | **mise** | Installs & pins CLI tools + language runtimes (kubectl, k9s, helm, node, eza, starship…) | `~/.config/mise/config.toml` | both |
| GUI + store apps | **Homebrew** + **mas** | macOS GUI casks, Mac App Store, mac-native CLIs (ffmpeg, ollama…) | [`Brewfile`](Brewfile) | macOS |
| System bootstrap | **apt** | Base libs + zsh on Linux | bootstrap script | WSL/Ubuntu |
| Shell | **zsh** + **zinit** | Interactive shell, plugins, aliases, keybinds | `~/.zshrc`, `~/.config/zsh/*` | both |
| Prompt | **starship** | Prompt rendering | `~/.config/starship.toml` | both |
| Terminal | **ghostty** | Terminal emulator | `~/.config/ghostty/config` | macOS |
| macOS settings | **defaults** + **dockutil** | OS prefs (dark mode, Finder, Dock) + dock contents | `home/.chezmoiscripts/*` | macOS |
| Git hooks | **hk** | Pre-commit secret scanning | [`hk.pkl`](hk.pkl) | this repo |
| Per-project tooling | **mise** + **hk** *(in the project)* | Per-repo tool versions & hooks — **not** this repo | each project's own `mise.toml` / `hk.pkl` | per-project |

Config you tune by hand (mise, starship, hk) is **schema-validated** in your
editor; see [Type-safety](#type-safety--intellisense).

---

## Shared (both operating systems)

These are identical on macOS and WSL/Ubuntu:

- **CLI toolchain** — declared once in [`home/dot_config/mise/config.toml`](home/dot_config/mise/config.toml).
  `mise` installs kubectl, k9s, helm, terraform, node, python, rust, gh,
  starship, eza, bat, fzf, zoxide, and the rest.
- **Shell** — zsh + [zinit](home/dot_zshrc.tmpl) (pinned) with
  autosuggestions, fast-syntax-highlighting, fzf-tab, completions.
  Modular config in [`home/dot_config/zsh/`](home/dot_config/zsh).
- **Prompt** — [starship](home/dot_config/starship.toml) (kubernetes /
  terraform / cloud aware).
- **Git** — [identity, SSH commit signing, and a work `includeIf`](home/dot_config/git/),
  all templated from your answers to the `chezmoi init` prompts.
- **Git hooks** — [`hk.pkl`](hk.pkl) runs `trufflehog` on every commit.

## macOS

Adds, on top of the shared layer:

- **GUI apps + Mac App Store** — [`Brewfile`](Brewfile) (casks + `mas`),
  applied via `brew bundle`.
- **System preferences** — [`run_onchange_after_40-macos-defaults`](home/.chezmoiscripts/run_onchange_after_40-macos-defaults.sh.tmpl):
  dark mode, 24-hour clock, Finder icon view, Dock autohide / no-recents,
  Bluetooth + battery-% in the menu bar.
- **Dock** — [`run_onchange_after_50-dock`](home/.chezmoiscripts/run_onchange_after_50-dock.sh.tmpl)
  rebuilds the Dock from an explicit, ordered app list using `dockutil`.
- **Terminal** — [Ghostty](home/dot_config/ghostty/config).

Some things stay **imperative** by necessity — see
[docs/how-to/manual-app-setup.md](docs/how-to/manual-app-setup.md) (Affinity
suite, Snapply dictation, VS Code/Chrome sign-in sync, SSH keys).

## WSL / Ubuntu

Adds, on top of the shared layer:

- **System bootstrap** — [`run_once_before_10-bootstrap`](home/.chezmoiscripts/run_once_before_10-bootstrap.sh.tmpl)
  installs `build-essential zsh curl git file unzip` via `apt`. Everything
  else comes from `mise`, so there is **no Brewfile and no Homebrew** on Linux.
- No GUI / Dock / `defaults` steps run (guarded by `{{ "{{ if eq .chezmoi.os \"darwin\" }}" }}`).

See [docs/tutorials/getting-started.md](docs/tutorials/getting-started.md) for
the WSL distro import steps.

## Per-project (not managed here)

Project-level tooling lives **in each project repo**, never here:

- `mise.toml` pins that project's tool/runtime versions (overriding the global
  config in this repo).
- `hk.pkl` defines that project's own git hooks.

This repo is strictly **machine/global** config. The boundary is deliberate:
cloning a project should configure the project; cloning this repo should
configure the machine.

---

## Type-safety / IntelliSense

The config you edit by hand validates against a schema in-editor. Open the repo
in VS Code and accept the [recommended extensions](.vscode/extensions.json).

| File | Validated by |
|---|---|
| `hk.pkl` | Pkl language server (real static types) |
| `mise/config.toml` | `#:schema` + Even Better TOML |
| `starship.toml` | `$schema` + Even Better TOML |
| shell scripts | shellcheck |

Untyped-by-nature files (`Brewfile`, `ghostty/config`, macOS `defaults`) are
validated by their own tools (`brew bundle`, `ghostty +show-config`, `defaults`).

---

## Documentation

Organised by the [Diátaxis](https://diataxis.fr) framework:

- **Tutorial** — [getting started on a fresh machine](docs/tutorials/getting-started.md)
- **How-to** — [add a package](docs/how-to/add-a-package.md) ·
  [add a dotfile](docs/how-to/add-a-dotfile.md) ·
  [customize macOS / the Dock](docs/how-to/customize-macos.md) ·
  [manual app setup](docs/how-to/manual-app-setup.md) ·
  [PHP & Laravel](docs/how-to/php-laravel.md)
- **Reference** — [repository layout](docs/reference/repository-layout.md) ·
  [commands cheatsheet](docs/reference/commands.md)
- **Explanation** — [architecture & design decisions](docs/explanation/architecture.md)
- **Runbook** — [day-to-day operations & troubleshooting](docs/runbook.md)

## Credits

- [`@use-the-fork`](https://github.com/use-the-fork) — first introduced me to declarative config.
- [chezmoi](https://chezmoi.io), [mise](https://mise.jdx.dev), [hk](https://hk.jdx.dev), [starship](https://starship.rs).
