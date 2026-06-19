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
