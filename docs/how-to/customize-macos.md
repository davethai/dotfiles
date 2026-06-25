# How-to: Customize macOS settings & the Dock

Two scripts own macOS system state. Both re-run automatically when their
contents change.

## System preferences (`defaults`)

File: `home/.chezmoiscripts/run_onchange_after_40-macos-defaults.sh.tmpl`

Each setting is a `defaults write` line. To add one:

1. Find the domain + key. Discover changes by diffing:
   ```sh
   defaults read > /tmp/before
   # change the setting in System Settings
   defaults read > /tmp/after
   diff /tmp/before /tmp/after
   ```
2. Add the line, matching the value type (`-bool`, `-int`, `-float`, `-string`).
3. `chezmoi apply`. The trailing `killall` restarts the affected services.

Current settings: dark mode, 24-hour clock, Finder icon view, Dock autohide /
no-recents / zero autohide-delay, Bluetooth + battery-% in the menu bar.

## The Dock (`dockutil`)

File: `home/.chezmoiscripts/run_onchange_after_50-dock.sh.tmpl`

The Dock is rebuilt from scratch each run from the ordered `apps=( … )` array.
To change it, edit that array — order in the file = order in the Dock. Apps that
aren't installed are skipped (so a partial machine doesn't error).

```sh
chezmoi apply        # wipes and rebuilds the Dock, then `killall Dock`
```

> `dockutil` is installed by the `Brewfile`. If it's missing the script no-ops
> with a notice rather than failing.

## Re-applying only the macOS scripts

```sh
chezmoi state delete-bucket --bucket=scriptState   # forget run_onchange hashes
chezmoi apply
```

…or just touch the script (any content change re-triggers it).
