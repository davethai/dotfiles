# How-to: Manual app setup (the imperative bits)

Not everything can be declarative. These steps are deliberately left manual —
do them once after `chezmoi apply`.

## SSH key (for git signing + GitHub)

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub        # add to GitHub → Settings → SSH and GPG keys
```

If your public key differs from the default in `chezmoi init`, re-run
`chezmoi init` and paste the correct `ssh-ed25519 …` line at the signing-key
prompt (it feeds `~/.config/git/allowed_signers`).

## Sign-in based sync (no config to manage)

- **VS Code** — sign in, enable **Settings Sync**. Extensions/settings restore
  automatically. (This is why VS Code config isn't in this repo.)
- **Google Chrome** — sign in to sync bookmarks, extensions, passwords.

## macOS apps not in the Mac App Store / Homebrew

- **Affinity suite** (Photo, Designer, Publisher) — download from your
  [Serif account](https://store.serif.com/account/licences); no longer on the
  App Store.
- **Snapply** (AI dictation) — install manually; not distributable declaratively.

## Mac App Store apps

The `Brewfile` has `mas` entries commented out (mas errors when an app is
already installed). On a genuinely fresh machine, uncomment them before
`brew bundle`:

```ruby
mas "Kindle",    id: 602584613
mas "Logic Pro", id: 634148309
```

## VS Code custom folder icons

This repo ships custom folder icons under `vscode/icons/`. To use them:

```sh
cp -r ~/.local/share/chezmoi/vscode/icons ~/.vscode/extensions/
```
