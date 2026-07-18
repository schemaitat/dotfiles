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

```sh
brew install stow
git clone <remote-url> ~/dotfiles
cd ~/dotfiles
stow -v -t ~ tmux workmux nvim zsh
```

If a target file already exists (e.g. a stock `.zshrc`), remove/back it up first,
or run `stow --adopt -t ~ <package>` to pull the existing file into the repo
instead of overwriting it (then check `git diff` to make sure nothing unwanted
was adopted).

## Adding a new package

```sh
mkdir -p dotfiles/<name>/path/to/mirror
mv ~/path/to/config dotfiles/<name>/path/to/mirror/
cd dotfiles && stow -v -t ~ <name>
```

## Un-stow (remove symlinks, keep files in repo)

```sh
cd ~/dotfiles && stow -D -t ~ tmux workmux nvim zsh
```

## Re-stow after editing package structure

```sh
cd ~/dotfiles && stow -R -t ~ tmux workmux nvim zsh
```
