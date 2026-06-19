# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# History
HISTSIZE=50000
SAVEHIST=50000

# Locale
export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'

# Colors
export CLICOLOR=1
export BAT_THEME="Dracula"

# Platform-specific setup
if [[ "$(uname)" == "Darwin" ]]; then
  # Homebrew paths (Apple Silicon / Intel)
  if [[ -d /opt/homebrew/share ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    HOMEBREW_PREFIX="/usr/local"
  fi
  ZSH_AUTOSUGGEST_PATH="$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_SYNTAX_HIGHLIGHTING_PATH="$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

  if command -v gdircolors >/dev/null 2>&1; then
    eval "$(gdircolors -b)" 2>/dev/null
  fi
else
  ZSH_AUTOSUGGEST_PATH="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_SYNTAX_HIGHLIGHTING_PATH="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  eval "$(dircolors -b)" 2>/dev/null
fi

# Which plugins to load.
plugins=(
  git
  docker
  npm
  node
  gh
  zoxide
  extract
  colored-man-pages
  sudo
  web-search
  command-not-found
  dirhistory
)

# Better completion behavior.
setopt AUTO_CD
setopt COMPLETE_IN_WORD
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt INTERACTIVE_COMMENTS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

source $ZSH/oh-my-zsh.sh

# Load Powerlevel10k config.
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Platform-specific aliases
if [[ "$(uname)" == "Darwin" ]]; then
  # Mac uses different names for some tools via brew
  alias ls='eza -lh --group-directories-first --icons=auto --classify'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git --classify'
  alias lta='lt -a'
  alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
  alias fd='fd'
  alias bat='bat'
  alias cd='z'
  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'
  n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
  alias g='git'
  alias d='docker'
  alias gcm='git commit -m'
  alias gcam='git commit -a -m'
  alias gcad='git commit -a --amend'
else
  # Linux aliases
  if [[ -f "$HOME/.local/share/omakub/defaults/bash/aliases" ]]; then
    source "$HOME/.local/share/omakub/defaults/bash/aliases"
  else
    alias ls='eza -lh --group-directories-first --icons=auto --classify'
    alias lsa='ls -a'
    alias lt='eza --tree --level=2 --long --icons --git --classify'
    alias lta='lt -a'
    alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
    alias fd='fdfind'
    alias bat='batcat'
    alias cd='z'
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
    alias g='git'
    alias d='docker'
    alias gcm='git commit -m'
    alias gcam='git commit -a -m'
    alias gcad='git commit -a --amend'
  fi
fi

# zsh-autosuggestions (loads after p10k)
[[ -f "$ZSH_AUTOSUGGEST_PATH" ]] && source "$ZSH_AUTOSUGGEST_PATH"

# zsh-syntax-highlighting — must be loaded last
[[ -f "$ZSH_SYNTAX_HIGHLIGHTING_PATH" ]] && source "$ZSH_SYNTAX_HIGHLIGHTING_PATH"

# Show system info on startup.
if [[ -o interactive ]] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
