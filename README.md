# My dotfiles

`$HOME/dotfiles` structure must match `$HOME`

## Mac Step

### Requirements

Ensure you have the following installed on your system.

1. Install [Git](https://www.gnu.org/software/stow/)

```shell
brew install git
```

2. Install [GNU stow](https://www.gnu.org/software/stow/)

```shell
brew install stow
```

Note: GNU stow has a default ignore file: https://www.gnu.org/software/stow/manual/html_node/Types-And-Syntax-Of-Ignore-Lists.html

### Installation

1. Clone the repo in your `$HOME` directory

```shell
git clone https://github.com/davethai/dotfiles.git
```

2. Got into the `$HOME/dotfiles` directory

```shell
cd dotfiles
```

3. Use GNU stow to create symlinks to `$HOME`

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