# How-to: Add or edit a dotfile

All managed files live under `home/` and follow chezmoi's
[source-state naming](https://chezmoi.io/reference/source-state-attributes/).

## Naming cheatsheet

| Target | Source filename under `home/` |
|---|---|
| `~/.zshrc` | `dot_zshrc` |
| `~/.config/foo/bar` | `dot_config/foo/bar` |
| a templated file | add `.tmpl` suffix (e.g. `dot_zshrc.tmpl`) |
| a private/secret file | `private_` prefix (mode 600) |

## Add a new dotfile

Easiest — let chezmoi capture an existing file:

```sh
chezmoi add ~/.config/foo/bar.conf      # imports it into home/
chezmoi cd                              # jump into the source dir
# edit, then:
chezmoi apply
```

Or create it directly under `home/` using the naming rules above.

## Make a file OS-aware (template it)

Rename it with a `.tmpl` suffix and use Go template guards:

```gotemplate
{{ if eq .chezmoi.os "darwin" }}
# macOS-only lines
{{ else }}
# Linux-only lines
{{ end }}
```

Available data: `.chezmoi.os`, `.chezmoi.arch`, `.chezmoi.homeDir`, plus your
init answers (`.name`, `.email`, `.workEmail`, `.workDir`, `.signingKey`).

> Prefer runtime shell checks (`[[ "$OSTYPE" == darwin* ]]`) inside `.zsh`
> files over templating them — it keeps them plain, lintable shell. Reserve
> `.tmpl` for files that genuinely need per-machine values (like git config).

## Edit an existing dotfile

Edit the **source** under `home/`, not the file in `$HOME`:

```sh
chezmoi edit ~/.zshrc     # opens the source, applies on save
# or edit home/dot_zshrc.tmpl directly, then:
chezmoi apply
```

`chezmoi diff` shows exactly what would change before you apply.
