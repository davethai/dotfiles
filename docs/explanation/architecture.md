# Explanation: Architecture & design decisions

This document records *why* the stack is shaped the way it is. It's the
reasoning, not the instructions — for those, see the how-to guides.

## First principle: one responsibility per layer

A machine setup has a handful of genuinely distinct jobs:

1. **Place config files** in `$HOME`, with per-machine variation.
2. **Install CLI tools** and language runtimes.
3. **Install GUI applications.**
4. **Set OS-level preferences.**
5. **Enforce repo hygiene** (git hooks).

The failure mode of most dotfiles setups is letting one tool sprawl across
several of these jobs, which couples unrelated things and makes any single
change risky. So each job is assigned to the tool that is *idiomatic* for it,
and to no other:

| Job | Tool | Why this one |
|---|---|---|
| Place config | **chezmoi** | Purpose-built for dotfiles: templating, per-machine data, secrets, scripts. OS-agnostic. |
| Install CLI tools | **mise** | One declarative config that works **identically** on macOS and Linux; version pinning; already used per-project. |
| Install GUI apps | **Homebrew** | Native casks + Mac App Store; the macOS standard. |
| OS preferences | **defaults / dockutil** | The actual macOS primitives, scripted idempotently. |
| Git hooks | **hk** | Fast, Pkl-typed, mise-native. |

## Why chezmoi over a bare git repo or stow

- **Templating + per-machine data.** Git identity, work email, and OS-specific
  branches come from one source without per-machine forks.
- **Provisioning scripts** (`run_once`/`run_onchange`) live next to the files
  and run in a defined order, so "install tools" and "place config" are one
  `apply`, not two systems.
- **Idempotent and inspectable** (`chezmoi diff`) — unlike imperative install
  scripts.

## Why mise for CLI tools — even over a second Brewfile

The bulk of the toolchain is CLI dev tools, and they're needed on **both** OSes.
The options were:

- *Homebrew on Linux too* — gives one Brewfile, but Linuxbrew is the weakest
  link (heavier, occasional source builds, an extra moving part in WSL), and
  GUI casks don't exist on Linux anyway, so it wouldn't actually unify the GUI
  layer.
- *apt + manual installers on Linux* — most of these tools (k9s, starship, eza,
  helm…) aren't in stock apt, so this means per-tool special-casing and drift.
- ***mise on both*** *(chosen)* — one `config.toml`, identical on macOS and
  Linux, via its aqua/ubi backends; prebuilt binaries (no compiling); version
  pinning we already rely on per-project. CLI tools live in the manager built
  for versioned CLI tools; GUI/system stuff stays in Homebrew where casks are
  native. Each tool in its idiomatic home, and real DRY where it counts.

The one ordering cost — shell-critical tools (starship, eza, zoxide) arrive via
mise shims — is handled by activating mise early in `.zshrc`, before the prompt
and plugins load.

## Legibility over total purity

The stack favors **legibility**: anyone can read the Brewfile, the mise config,
and five short shell scripts and know exactly what the machine will look like.
Some things stay imperative (Affinity, Snapply, sign-in sync) — that's an
accepted, documented cost, not a leak.

## Why type-safety matters here

The files you edit by hand (mise, starship, hk) carry schemas, so the editor
catches typos and invalid keys *before* `apply`. The inherently-untyped files
(Brewfile, `defaults`, ghostty) are small and validated by their own tools.
Net result: the surface where mistakes are likely is the surface that's typed.

## The per-project boundary

This repo configures the **machine**. Project-specific tool versions and hooks
live in each project's own `mise.toml` / `hk.pkl`, which override the globals
here. Cloning a project configures the project; cloning this repo configures the
machine. Keeping that line bright is what stops a "dotfiles" repo from slowly
absorbing every project's quirks.
