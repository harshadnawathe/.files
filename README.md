# .files (Dot files)

This repository contains the configuration files
for various applications I use on my MacBook.

> [!NOTE]
> Clone this repository in your home directory.

## Install applications using [Homebrew](https://brew.sh/)

- Install Homebrew.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Install applications using brew bundle.

```sh
ln -s Brewfile ~/Brewfile
cd ~
brew bundle check || brew bundle --all --cleanup; brew bundle cleanup --force; brew cleanup --prune=all; brew upgrade
```

## Create symbolic links to configuration using [stow](https://www.gnu.org/software/stow/)

```sh
stow .
```
