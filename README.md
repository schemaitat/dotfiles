# dotfiles

Single source of truth for tmux, workmux, nvim, and zsh config, managed with
[GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a "package" whose contents mirror `$HOME`.
Stow symlinks package contents into `$HOME`.

## Layout

```
dotfiles/
  tmux/.tmux.conf
  workmux/.config/workmux/config.yaml
  nvim/.config/nvim/...
  zsh/.zshrc .zprofile .zshenv
```

## Bootstrap on a new machine

Requires [`just`](https://github.com/casey/just) (`brew install just` / `apt install just`).

```sh
git clone <remote-url> ~/dotfiles
cd ~/dotfiles
just install
```

`just install` installs `stow` if missing (via `brew` or `apt`) and symlinks
all packages into `$HOME`.

If a target file already exists (e.g. a stock `.zshrc`), remove/back it up first,
or run `just adopt` to pull the existing file into the repo instead of
overwriting it (then check `git diff` to make sure nothing unwanted was
adopted).

## Adding a new package

```sh
mkdir -p dotfiles/<name>/path/to/mirror
mv ~/path/to/config dotfiles/<name>/path/to/mirror/
```

Add `<name>` to the `packages` variable in the `justfile`, then run:

```sh
just restow
```

## Other commands

```sh
just uninstall  # remove symlinks, keep files in repo
just restow      # re-stow after editing package structure
just adopt       # pull existing target files into the repo
```
