# My dotfiles

## Windows (WSL 2) - NixOS

### Requirements

1. WSL 2 NixOS is enabled

#### Installing WSL 2 (NixOS)

1. Ensure WSL is enabled.

```powershell
wsl --install --no-distribution
```

2. Download `nixos-wsl.tar.gz` from the [latest release](https://github.com/nix-community/NixOS-WSL/releases/latest)

3. Import the tarball into WSL 2

```powershell
wsl --import NixOS $env:USERPROFILE\NixOS\ nixos-wsl.tar.gz --version 2
```

4. Set NixOS as the default distro (optional - but recommended)

```powershell
wsl --set-default NixOS
```

5. You can now run NixOS (`-d NixOS` is not required because NixOS is default distro)

```powershell
wsl
```

#### Installation

1. Clone the repo

```shell
nix-shell -p git --run 'git clone https://github.com/davethai/dotfiles.git ~/.dotfiles'
```

2. Apply the appropriate NixOS hostname configuration (ex: `dewgong` is shown here) and shutdown the WSL 2 Virtual Machine (VM)

```shell
nix-shell -p git --run 'sudo nixos-rebuild switch --flake ~/.dotfiles/nix#dewgong'
```

3. Reconnect to WSL 2 VM

```powershell
wsl
```

## Darwin (MacOS) - Nix

### Requirements

1. Nix package manager is installed
2. Command Line Tools for Xcode

#### Install [Nix](https://nixos.org/download/)

1. Run the command below

```shell
sh <(curl -L https://nixos.org/nix/install)
```

#### Install Xcode Command Line Tools (Installs git)

1. Run the command below

```shell
xcode-select --install
```

#### Installation

1. Clone dotfiles repo

```shell
nix-shell -p git --run 'git clone https://github.com/davethai/dotfiles.git ~/.dotfiles'
```

2. Run `nix-darwin` with `flake.nix` and replace with the appropriate hostname. `rhydon` is shown here.

```shell
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix#rhydon
```

3. `cd` into `$HOME/.dotfiles` directory

```shell
cd ~/.dotfiles
```

4. Install Xcode from Mac App Store imperatively

5. Sign in to [VSCode](https://code.visualstudio.com/) to sync settings, and run `Cmd` + `Shift` + `P` = `Install code command in path` to install code

6. Copy vscode icons to extensions

```shell
cp -r ~/.dotfiles/vscode/icons ~/.vscode/extensions
```

## Host Naming Convention

**Host Short Name:** Pokemon

**Host Long Name:** [LOCATION]-[TYPE]-[ROLE]-[UNIQUE_ID]

**LOCATION** (Not Applicable to TYPE `L`)
[COUNTRY_CODE (ISO 3166-1 alpha-2)]-[ADMINISTRATIVE_AREA]-[LOCALITY]-[B-BUILDING_CODE]-[F-FLOOR]-[R-ROOM]

**TYPE**

- D = Desktop
- L = Laptop
- S = Server
- P = Printer
- W = WiFi Access Point

**ROLE**

- WS - Workstation
- APP - Application Server
- DB - Database Server

**UNIQUE_ID** (Numeric)

## Maintenance

1. Update flake

```shell
cd ~/.dotfiles/nix && nix flake update
```

2. Rebuild

```shell
sudo darwin-rebuild switch --flake ~/.dotfiles/nix#hostname
```

## Credits

- [@use-the-fork](https://github.com/use-the-fork) - for introducing to me to Nix!
- [@NotAShelf/nyx](https://github.com/NotAShelf/nyx) - scalable file structure and code inspiration
