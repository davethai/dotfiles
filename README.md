# My dotfiles

`$HOME/dotfiles` structure must match `$HOME`

## Mac Step

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

1. Make sure you are in `$HOME` directory

```shell
nix-shell -p git --run 'git clone https://github.com/davethai/dotfiles.git dotfiles'
```

2. Run `nix-darwin` with `flake.nix`

```shell
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/dotfiles/nix#Daves-MacBook-Pro
```

3. `cd` into `$HOME/dotfiles` directory

```shell
cd ~/dotfiles
```

4. Use GNU stow to create symlinks to `$HOME`

```shell
stow .
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

### GNU Stow

Note: GNU stow has a default ignore file: https://www.gnu.org/software/stow/manual/html_node/Types-And-Syntax-Of-Ignore-Lists.html
