# Tutorial: Getting started on a fresh machine

This walks you from a brand-new machine to a fully configured one. Follow it
top to bottom — no prior knowledge of the stack required.

By the end you'll have: every CLI tool installed, your shell + prompt
configured, git identity and signing set up, and (on macOS) your apps, system
preferences, and Dock in place.

---

## What the one-liner does

```sh
sh -c "$(curl -fsSL https://chezmoi.io/get)" -- init --apply davethai
```

1. Downloads `chezmoi` to a temp location.
2. Clones this repo to `~/.local/share/chezmoi`.
3. Runs `chezmoi init`, which **prompts** for your git identity (name, email,
   signing key, optional work email/dir).
4. Runs `chezmoi apply`, which writes every dotfile and executes the
   provisioning scripts (bootstrap → mise → brew → macOS defaults → Dock).

You can re-run `chezmoi apply` any time; it's idempotent.

---

## macOS

### Prerequisites

- macOS on Apple silicon.
- You'll be asked for your password (Homebrew install, `chsh`).

### Steps

1. Open **Terminal.app** (just for the bootstrap; you'll switch to Ghostty after).
2. Run the one-liner above.
3. When prompted, accept the **Xcode Command Line Tools** GUI install if it
   appears, then re-run the one-liner.
4. Answer the git identity prompts.
5. Wait for `brew bundle` and `mise install` to finish (first run is the slow one).
6. Restart your shell (`exec zsh`) — you should see the starship prompt.
7. Open **Ghostty** and make it your default terminal.

### After

- Sign in to **VS Code** (Settings Sync) and **Chrome** (sync).
- Install the imperative apps in [manual app setup](../how-to/manual-app-setup.md).
- Generate an SSH key if you don't have one (same doc).

---

## WSL / Ubuntu

### Prerequisites — install the distro (run in PowerShell)

```powershell
wsl --install -d Ubuntu
```

Launch Ubuntu once to create your user, then update:

```sh
sudo apt-get update && sudo apt-get upgrade -y
```

### Steps

1. In the Ubuntu shell, install chezmoi and let it clone + apply in one go:
   ```sh
   sh -c "$(curl -fsSL https://chezmoi.io/get)" -- init --apply davethai
   ```
   chezmoi clones the repo into `~/.local/share/chezmoi`, prompts for your git
   identity, then runs the bootstrap.
2. Answer the git identity prompts (leave `signingKey` blank if this box has no
   SSH key yet).
3. Enter your password when **`sudo apt`** installs the base system (incl. zsh).
   `mise` then installs the CLI toolchain.
4. `exec zsh` — Catppuccin powerline prompt.

### On Windows — manual (WSL can't manage the host)

The terminal **window** is a Windows app, so fonts, glyphs, and background are
configured on the Windows side — one-time manual steps:

- **Nerd Font** *(required for glyphs)* — install one (e.g.
  [FiraCode / JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads))
  on Windows, then set it as the terminal font. Windows Terminal: profile →
  Appearance → Font face. VS Code (Remote-WSL) already uses `FiraCode Nerd Font`
  (synced) — just install that font on Windows. Without it you get boxes (▯).
- **Background / theme** — to match macOS, set your terminal background to
  Catppuccin Mocha `#1e1e2e` (Windows Terminal: a color scheme; VS Code: theme).

### Notes

- **No Homebrew, Herd, dock, or `defaults`** run on Linux — those steps are
  guarded out with `{{ if eq .chezmoi.os "darwin" }}` checks. `mise` provides the CLI tools.
- **Containers**: the bootstrap installs `podman` + `podman-compose` (rootless) —
  run `podman-compose up -d`. Podman Desktop is an optional Windows-side GUI, not
  needed for the CLI.
- **PHP**: not part of the stack (Herd is macOS-only). Install the version a
  project needs via the `ondrej/php` PPA (manual — it's not in the bootstrap, as
  it lags brand-new Ubuntu releases) and switch with `update-alternatives`:
  ```sh
  sudo add-apt-repository -y ppa:ondrej/php && sudo apt update
  sudo apt install -y php8.3 php8.3-{cli,common,mbstring,xml,curl,zip,bcmath,mysql,intl,gd}
  sudo update-alternatives --set php /usr/bin/php8.3
  ```
  If the PPA has nothing for your Ubuntu release yet, use `mise use php@8.3`
  (compiles) or default-repo PHP. PHP 8.5+ is often too new for an inherited
  `composer.lock`.

---

## Verify it worked

```sh
mise doctor          # toolchain health
mise ls              # installed tools
starship --version   # prompt
git config --get user.email
chezmoi doctor       # chezmoi health
```

Next: skim the [runbook](../runbook.md) for day-to-day operations.
