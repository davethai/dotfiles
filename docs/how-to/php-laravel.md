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

## Bring a project up

```sh
composer install                      # PHP deps (reproduces composer.lock)
mise use node@lts && npm install      # front-end (Vite); pins Node in mise.toml
cp .env.example .env && php artisan key:generate
podman-compose up -d                  # DB/redis (or `docker compose up -d`)
php artisan migrate
```

Containers use `podman` on both OSes (the managed `~/.config/containers/registries.conf`
makes unqualified image names like `redis` resolve to Docker Hub).

## WSL / Ubuntu — PHP

Herd is macOS/Windows only. On WSL, the usual source is the **`ondrej/php` PPA**
(every version side-by-side). Add it **manually** — it's deliberately *not* in
the bootstrap, because the PPA lags brand-new Ubuntu releases (a release with no
PPA packages 404s and breaks `apt update`):

```sh
sudo add-apt-repository -y ppa:ondrej/php && sudo apt update
sudo apt install -y php8.3 php8.3-{cli,common,mbstring,xml,curl,zip,bcmath,mysql,intl,gd}
sudo update-alternatives --set php /usr/bin/php8.3   # global switch
```

If the PPA has no release for your Ubuntu version yet, use **`mise use php@8.3`**
(compiles from source) or the default-repo PHP. `update-alternatives` is a
**global** switch (not per-project like Herd). Containers run via `podman-compose`.
