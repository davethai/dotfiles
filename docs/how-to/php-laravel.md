# How-to: PHP & Laravel projects

PHP is the one tool **not** managed by mise on macOS — it's managed by
**[Laravel Herd](https://herd.laravel.com)** (installed via the Brewfile,
`cask "herd"`). Herd bundles PHP (multiple versions), Composer, nginx, and
`*.test` local domains with zero compiling.

> Why not mise? Every other tool ships prebuilt binaries; PHP would have to be
> compiled from source per version. Herd is the macOS/Laravel-community standard
> and avoids that entirely. Node, etc. still come from mise — a Laravel project
> typically uses **Herd for PHP** and a project `mise.toml` for **Node** (Vite).

## First-time setup (once)

1. Open **Herd** (`/Applications/Herd.app`) and complete the first-run wizard.
   It installs PHP + Composer and puts them on your `PATH`.
2. Verify in a new shell:
   ```sh
   exec zsh
   which php composer        # → Herd's shims (~/Library/Application Support/Herd/...)
   php -v                     # Herd's PHP
   ```
3. (Optional) Remove the old Homebrew PHP so there's one source of truth:
   ```sh
   brew uninstall php 2>/dev/null || true
   ```

## Start a new Laravel project

```sh
cd ~/Documents/dev
composer create-project laravel/laravel myapp
cd myapp
herd open                 # or visit http://myapp.test
```

Herd auto-serves any folder under its parked paths at `<folder>.test`. To park
your dev directory once: open Herd → **Sites** → add `~/Documents/dev` (or run
`herd park` from inside it).

## Set a per-project PHP version

This is the Herd equivalent of a per-project `mise.toml` override:

```sh
cd ~/Documents/dev/myapp
herd use 8.3              # pins PHP 8.3 for this site only
herd which-php            # confirm
```

Herd records this per-site (in its UI / config), overriding the global default —
other projects keep their own versions. Switching is instant (no compile).

## Node / front-end tooling (still mise)

Laravel's Vite build uses Node, which **does** come from mise. Pin it per project:

```sh
cd ~/Documents/dev/myapp
mise use node@22         # writes ./mise.toml, overrides global node
npm install && npm run dev
```

So a Laravel repo commonly has:
- **Herd** → PHP version (per-site)
- **`mise.toml`** → Node version (committed with the repo)
- **`composer.json` / `package.json`** → app dependencies

## Working on an existing / inherited repo

Use **`composer install`**, never `composer update`:

```sh
composer install
```

`install` reproduces the exact versions pinned in `composer.lock`. `composer
update` re-resolves everything from scratch and can swap versions or drop ones
flagged with security advisories (the *"not loaded because they are affected by
security advisories"* errors) — which is why a repo that works fine for its
author explodes if you `update` it.

If `composer install` reports *"your lock file does not contain a compatible set
of packages"*, that's a **PHP version mismatch**, not a missing package — match
your PHP to the project's `"php"` constraint in `composer.json`. PHP 8.5+ is
frequently *too new* for an older lock; install the right version (below) and
retry. (`--ignore-platform-reqs` forces it, but a wrong PHP can break things at
runtime — prefer matching.)

Then the rest:
```sh
mise use node@lts && npm install      # front-end (Vite); pins Node in mise.toml
cp .env.example .env && php artisan key:generate
podman-compose up -d                  # start DB/redis (or `docker compose up -d`)
php artisan migrate
```

## WSL / Ubuntu — PHP

Herd is macOS/Windows only. On WSL, PHP comes from the **`ondrej/php` PPA** (added
by the bootstrap), which makes every version installable side-by-side:

```sh
sudo apt install -y php8.3 php8.3-{cli,common,mbstring,xml,curl,zip,bcmath,mysql,intl,gd}
sudo update-alternatives --set php /usr/bin/php8.3   # switch the system default
php -v
```

`update-alternatives` switches PHP **globally**, not per-project like Herd. For
per-directory PHP that mirrors your `mise.toml` Node setup, use `mise use php@8.3`
— but mise compiles PHP from source on Linux (slower). Containers come from
`podman-compose`, also installed by the bootstrap: `podman-compose up -d`.
