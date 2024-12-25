# My dotfiles

## WSL2 (NixOS)

### Requirements

1. Ensure WSL is enabled.

```powershell
wsl --install --no-distribution
```

2. Download `nixos-wsl.tar.gz` from the [latest release](https://github.com/nix-community/NixOS-WSL/releases/latest)

3. Import the tarball into WSL2

```powershell
wsl --import NixOS $env:USERPROFILE/NixOS nixos-wsl.tar.gz --version 2
```

4. Set NixOS as the default

```powershell
wsl --set-default NixOS
```

5. You can now run NixOS (`-d NixOS` is not required because NixOS is default distro)

```powershell
wsl
```

### Installation

1. Clone repo

```shell
nix-shell -p git --run 'git clone https://github.com/davethai/dotfiles.git ~/dotfiles'
```

2. Apply the configuration and shutdown the WSL2 VM

```shell
sudo nixos-rebuild switch --flake ~/dotfiles/nix#asus-tuf-gaming.nix && sudo shutdown -h now
```

3. Reconnect to WSL2 VM

```powershell
wsl
```

### Making changes

1. Update Nix flake (Flake inputs updated)

```shell
nix flake update
```

2. Any changes to `flake.nix` run to apply changes

```shell
sudo nixos-rebuild switch --flake ~/dotfiles/nix#asus-tuf-gaming.nix
```

## Darwin (MacOS)

### Requirements

Ensure you have the following installed on your system.

1. [Nix](https://nixos.org/download/)

```shell
sh <(curl -L https://nixos.org/nix/install)
```

2. Command Line Tools

```shell
xcode-select --install
```

### Installation

1. Clone repo

```shell
nix-shell -p git --run 'git clone https://github.com/davethai/dotfiles.git ~/dotfiles'
```

2. Run `nix-darwin` with `flake.nix`

```shell
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/dotfiles/nix#macbook-pro-m1-max-16
```

3. `cd` into `$HOME/dotfiles` directory

```shell
cd ~/dotfiles
```

### Making changes

1. Any changes to `flake.nix` run to apply changes

```shell
darwin-rebuild switch --flake ~/dotfiles/nix
```

### Upgrading packages

1. Update Nix flake (Flake inputs updated)

```shell
nix flake update
```

2. Update Nix packages

```shell
darwin-rebuild switch --flake ~/dotfiles/nix
```

3. Update Homebrew packages (Only if autoUpdate or upgrade not `true`)

```shell
brew update
```

```shell
brew upgrade
```

### Manually installed

1. [Docker Desktop](https://docs.docker.com/desktop/setup/install/mac-install/)
2. Xcode

### VSCode

1. `Cmd` + `Shift` + `P` = `Install code command in path`
2. Copy vscode icons to extensions

```shell
cp -r ~/dotfiles/vscode/icons ~/.vscode/extensions/icons
```

## Credits

[@use-the-fork](https://github.com/use-the-fork) - for introducing to me to Nix!
[@NotAShelf/nyx](https://github.com/NotAShelf/nyx) - scalable file structure and code inspiration
