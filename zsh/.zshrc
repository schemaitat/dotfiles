# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opencode/bin:/opt/nvim-linux-x86_64/bin:$PATH"

ZSH_THEME=""

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

zstyle ':omz:update' mode auto  # update automatically without asking

plugins=(
  git
  z
  sudo
  colored-man-pages
  zsh-autosuggestions
  tmux
)

source $ZSH/oh-my-zsh.sh

# --- Completion ---
# compinit already runs inside oh-my-zsh.sh (with caching + async security
# check); calling it again here just redoes the full scan synchronously.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# --- aliases ---

alias clauded="claude --dangerously-skip-permissions"
alias wm="workmux"
alias wma="workmux add -a oc-auto -A -p"
alias wmd="workmux dashboard"
alias wms="workmux sidebar"
alias wml="workmux list"
wmo() {
  local handle
  handle=$(workmux list --json | jq -r '.[].handle' | fzf --prompt="worktree> ") || return
  [[ -n "$handle" ]] && workmux open "$handle"
}

# --- opencode ---

export PATH=/Users/andre/.opencode/bin:$PATH
alias t="task"
alias oc="opencode"
alias oca="opencode --auto"

# --- pixi ---

export PATH="/Users/andre/.pixi/bin:$PATH"

# --- Local secrets (untracked) ---

[ -f "$HOME/.zshrc.secrets" ] && source "$HOME/.zshrc.secrets"

# --- oh-my-posh ---
eval "$(oh-my-posh init zsh --config catppuccin)"
