# dotfiles

Single source of truth for tmux, workmux, nvim, zsh, and opencode config,
managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a "package" whose contents mirror `$HOME`.
Stow symlinks package contents into `$HOME`.

## Layout

```
dotfiles/
  tmux/.tmux.conf
  workmux/.config/workmux/config.yaml
  nvim/.config/nvim/...
  zsh/.zshrc .zprofile .zshenv
  opencode/.config/opencode/...
```

## Prerequisites

Install the underlying tools before symlinking config. Commands below cover
macOS (Homebrew) and Ubuntu/WSL (apt).

### zsh

```sh
# macOS: zsh is preinstalled
brew install zsh   # only if missing/outdated

# Ubuntu/WSL
sudo apt update && sudo apt install zsh

# make zsh the default shell (both platforms)
chsh -s "$(which zsh)"
```

### oh-my-zsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

This `.zshrc` also expects these oh-my-zsh plugins to be installed as
custom plugins:

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
```

### oh-my-posh

```sh
# macOS
brew install jandedobbeleer/oh-my-posh/oh-my-posh

# Ubuntu/WSL
curl -s https://ohmyposh.dev/install.sh | bash -s
```

`.zshrc` references the `jandedobbeleer` theme bundled with oh-my-posh
(`.../themes/jandedobbeleer.omp.json`); no extra theme file needed.

### tmux (+ tpm plugin manager)

```sh
# macOS
brew install tmux

# Ubuntu/WSL
sudo apt update && sudo apt install tmux

# tpm (tmux plugin manager), required by .tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

After stowing `.tmux.conf` and starting tmux, press `prefix + I` (capital i)
to have tpm install the configured plugins (`tmux-sensible`,
`tmux-resurrect`, `tmux-continuum`).

### workmux

Not yet documented here — installation notes to be added later.

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
