packages := "tmux workmux nvim zsh"

# Install stow (if needed) and symlink all packages into $HOME
install:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v stow >/dev/null 2>&1; then
        if command -v brew >/dev/null 2>&1; then
            brew install stow
        elif command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y stow
        else
            echo "stow not found and no supported package manager detected; install stow manually" >&2
            exit 1
        fi
    fi
    stow -v -t "$HOME" {{packages}}

# Remove symlinks for all packages (keeps files in repo)
uninstall:
    stow -D -t "$HOME" {{packages}}

# Re-stow after editing package structure
restow:
    stow -R -t "$HOME" {{packages}}

# Adopt existing files at target paths into the repo instead of overwriting them
adopt:
    stow --adopt -t "$HOME" {{packages}}
