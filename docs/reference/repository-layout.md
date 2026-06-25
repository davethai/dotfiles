# Reference: Repository layout

```
.
├── .chezmoiroot                 # tells chezmoi the source lives in home/
├── Brewfile                     # macOS GUI apps, mas, mac-native CLIs
├── hk.pkl                       # git hooks (Pkl)
├── README.md                    # entry point + responsibilities map
├── .vscode/                     # editor: recommended extensions + schema wiring
│   ├── extensions.json
│   └── settings.json
├── .github/workflows/           # CI (trufflehog secret scan)
├── vscode/icons/                # custom VS Code folder-icon assets (manual install)
├── docs/                        # Diátaxis documentation (see below)
└── home/                        # chezmoi source root (everything here → $HOME)
    ├── .chezmoi.toml.tmpl       # init prompts → ~/.config/chezmoi/chezmoi.toml
    ├── dot_zshrc.tmpl           # → ~/.zshrc
    ├── .chezmoiscripts/         # provisioning scripts, run in numeric order
    │   ├── run_once_before_10-bootstrap.sh.tmpl
    │   ├── run_onchange_after_20-mise.sh.tmpl
    │   ├── run_onchange_after_30-brew.sh.tmpl          (darwin only)
    │   ├── run_onchange_after_40-macos-defaults.sh.tmpl (darwin only)
    │   └── run_onchange_after_50-dock.sh.tmpl          (darwin only)
    └── dot_config/              # → ~/.config/
        ├── mise/config.toml     # the cross-platform CLI toolchain
        ├── starship.toml        # prompt
        ├── ghostty/config       # terminal
        ├── bat/config
        ├── git/{config,config-work,allowed_signers}.tmpl
        └── zsh/{env,history,comp,binds,fzf,aliases}.zsh
```

## chezmoi naming rules used here

| Prefix/suffix | Meaning |
|---|---|
| `dot_` | becomes a leading `.` (`dot_zshrc` → `~/.zshrc`) |
| `.tmpl` | rendered as a Go template |
| `.chezmoiscripts/` | scripts run during `apply`, not copied to `$HOME` |
| `run_once_` | runs once per machine (tracked by content hash) |
| `run_onchange_` | re-runs whenever the rendered script changes |
| `_before_` / `_after_` | runs before/after the file-apply phase |
| `NN-` numeric prefix | execution order within a phase |

## Script execution order (during `chezmoi apply`)

1. `run_once_before_10-bootstrap` — pkg manager + mise + zsh
2. *(files written to `$HOME`)*
3. `run_onchange_after_20-mise` — `mise install`
4. `run_onchange_after_30-brew` — `brew bundle` *(macOS)*
5. `run_onchange_after_40-macos-defaults` — `defaults write` *(macOS)*
6. `run_onchange_after_50-dock` — `dockutil` *(macOS)*

`run_onchange` scripts that depend on an external file (Brewfile, mise config)
embed that file's `sha256sum` in a comment, so editing the file re-triggers the
script.
