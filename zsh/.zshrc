# ============================================
# PATH
# ============================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:${GOPATH:-$HOME/go}/bin"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/usr/bin/elixir"

# Bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && export PATH="$PATH:$BUN_INSTALL/bin"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
[[ -d "$PNPM_HOME" ]] && export PATH="$PATH:$PNPM_HOME"


# Final PATH cleanup
typeset -U PATH path

# ============================================
# Environment
# ============================================
export LANG=en_US.UTF-8
export EDITOR='nvim'
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE APPEND_HISTORY INC_APPEND_HISTORY

# fzf — use fd as backend
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ============================================
# Plugins
# ============================================
eval "$(sheldon source)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"

# ============================================
# Completion
# ============================================
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls $realpath'

# ============================================
# Keybindings
# ============================================
# Use built-in history search widgets and bind both common arrow-key sequences.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^OA' up-line-or-beginning-search
bindkey '^OB' down-line-or-beginning-search
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# ============================================
# Aliases & Functions
# ============================================
source "$HOME/.zsh_aliases"

mkcd() { mkdir -p "$1" && cd "$1"; }
project() { cd ~/Projects/$1; }

# ============================================
# Completions
# ============================================
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"
command -v uv &>/dev/null && eval "$(uv generate-shell-completion zsh)"

# ============================================
# Local overrides (machine-specific, untracked)
# ============================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
# bun completions
[ -s "/home/antonio/.bun/_bun" ] && source "/home/antonio/.bun/_bun"

# fnm
FNM_PATH="/home/antonio/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

export PATH="$HOME/.local/bin:$PATH"
