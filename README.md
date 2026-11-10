# .files (Dot files)

This repository contains the configuration files
for various applications I use on my MacBook.

> [!NOTE]
> Clone this repository to `~/.files` in your home directory.

## Installation Steps

Follow these steps in order to set up your environment on a new machine.

### 1. Install Homebrew
```sh
/bin/bash -c "\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install GNU Stow & Homebrew-File
Install the required tools to manage your symlinks and packages.
```sh
brew install stow rcmdnk/file/brew-file
```

### 3. Create Symbolic Links
Navigate to your dotfiles directory and use `stow` to link your configurations (including your Brewfile to its default location at `~/.config/brewfile/Brewfile`).
```sh
cd ~/.files
stow .
```

### 4. Install Applications & Packages
Run `brew-file` to read your newly symlinked Brewfile and install all your formulae and casks.
```sh
brew file install
```

## Managing Packages

Packages live in `.config/brewfile/`:

- `Brewfile.common` — shared by every machine.
- `Brewfile.<hostname>` — this machine only: things exclusive to it, plus
  anything still on trial.

`brew-wrap` rewrites `Brewfile.<hostname>` after every `brew` command, so new
installs land there automatically. Only packages installed on request are
recorded (`HOMEBREW_BREWFILE_ON_REQUEST`); dependencies are left to Homebrew.

Once a trial package has earned its place on every machine, promote it:

```sh
brewfile-promote atuin carapace claude
```

> [!IMPORTANT]
> Run `brew file install` immediately after `git pull`, before any other `brew`
> command. `brew file init` prunes every Brewfile down to what is installed
> here, so running it on a machine that is behind will delete the packages it
> is missing from `Brewfile.common`.
