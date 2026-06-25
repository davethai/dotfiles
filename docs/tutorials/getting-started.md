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

1. In the Ubuntu shell, run the one-liner above.
2. Answer the git identity prompts.
3. `apt` installs the base system; `mise install` installs the CLI toolchain.
4. Restart your shell (`exec zsh`) — starship prompt appears.

### Notes

- There is **no Homebrew on Linux** here by design — `mise` provides the tools.
- For a Nerd Font in Windows Terminal, install
  [JetBrainsMono Nerd Font](https://www.nerdfonts.com/) on Windows and select it
  in the Windows Terminal profile.

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
