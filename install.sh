#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/alivinshiva/zsh-setup.git"
MINIMAL=false

# ── Parse flags ──────────────────────────────────────────────────────────────
for arg in "$@"; do
  case "$arg" in
    --minimal) MINIMAL=true ;;
  esac
done

# ── Detect mode: piped via curl or run locally ──────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || true)"
# When run via "bash -c \"\$(curl ...)\"", BASH_SOURCE is unreliable and $0
# is "bash". In that case, always clone. When running install.sh directly
# from a local clone, SCRIPT_DIR will contain .zshrc and install.sh.
if [[ -f "$SCRIPT_DIR/install.sh" && -f "$SCRIPT_DIR/.zshrc" && "$SCRIPT_DIR" != "$HOME" ]]; then
  DOTFILES_DIR="$SCRIPT_DIR"
  echo "==> Running from local copy at $DOTFILES_DIR"
else
  echo "==> Downloading dotfiles from $REPO_URL"
  DOTFILES_DIR="$(mktemp -d)"
  git clone --depth=1 "$REPO_URL" "$DOTFILES_DIR"
fi

echo "==> Installing zsh setup from $DOTFILES_DIR"

# ── Detect platform ──────────────────────────────────────────────────────────
if [[ "$(uname)" == "Darwin" ]]; then
  OS="mac"
  if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Ensure brew is on PATH for Apple Silicon
    if [[ -f /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi
else
  OS="linux"
fi

# ── Install tools ────────────────────────────────────────────────────────────
CORE_TOOLS="zsh-autosuggestions zsh-syntax-highlighting zoxide eza bat fd fzf gh neovim"
EXTRA_TOOLS="fastfetch git-delta tldr lazygit lazydocker"

if $MINIMAL; then
  TOOLS="$CORE_TOOLS"
  echo "==> Minimal mode: installing only core tools"
else
  TOOLS="$CORE_TOOLS $EXTRA_TOOLS"
  echo "==> Installing all tools..."
fi

if [[ "$OS" == "mac" ]]; then
  # coreutils is always useful on mac
  brew install $TOOLS coreutils
elif [[ "$OS" == "linux" ]]; then
  echo "==> Installing tools via apt..."
  # Translate tool names for Linux
  APT_TOOLS="zsh-autosuggestions zsh-syntax-highlighting zoxide eza bat fd-find fzf gh git-delta tldr neovim"
  sudo apt update -qq
  sudo apt install -y $APT_TOOLS

  if ! $MINIMAL; then
    # fastfetch — from PPA
    if ! command -v fastfetch &>/dev/null; then
      sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
      sudo apt update -qq
      sudo apt install -y fastfetch
    fi

    # lazygit — from GitHub releases
    if ! command -v lazygit &>/dev/null; then
      LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
        | grep -Po '"tag_name": *"v\K[^"]*')
      curl -Lo /tmp/lazygit.tar.gz \
        "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
      tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
      sudo install /tmp/lazygit /usr/local/bin
    fi

    # lazydocker — from GitHub releases
    if ! command -v lazydocker &>/dev/null; then
      LAZYD_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest \
        | grep -Po '"tag_name": *"v\K[^"]*')
      curl -Lo /tmp/lazydocker.tar.gz \
        "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYD_VERSION}_Linux_x86_64.tar.gz"
      tar xf /tmp/lazydocker.tar.gz -C /tmp lazydocker
      sudo install /tmp/lazydocker /usr/local/bin
    fi
  fi
fi

# ── Install Oh My Zsh ────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "==> Oh My Zsh already installed"
fi

# ── Install Powerlevel10k theme ──────────────────────────────────────────────
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
  echo "==> Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  echo "==> Powerlevel10k already installed"
fi

# ── Fastfetch theme prompt ────────────────────────────────────────────────────
if command -v fastfetch &>/dev/null; then
  echo ""
  echo "==> Choose your fastfetch theme:"
  echo ""
  echo "  1) Full    — detailed system info with colored sections"
  echo "  2) Compact — minimal, clean, single-line entries"
  echo ""
  read -p "  Select theme [1/2] (default: 1): " FASTFETCH_CHOICE
  FASTFETCH_CHOICE="${FASTFETCH_CHOICE:-1}"
fi

# ── Install NVM (Node Version Manager) ──────────────────────────────────────
if [[ ! -d "$HOME/.nvm" ]]; then
  echo "==> Installing NVM..."
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "==> NVM already installed"
fi

# ── Install fnm (Fast Node Manager) ─────────────────────────────────────────
if ! command -v fnm &>/dev/null; then
  if command -v node &>/dev/null; then
    echo "==> Node.js detected, skipping fnm installation"
  else
    echo ""
    echo "==> Node.js is not installed."
    read -p "    Install fnm (Fast Node Manager) for Node.js version management? [y/N] " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      if ! command -v unzip &>/dev/null; then
        echo "==> Installing unzip (required for fnm)..."
        if [[ "$OS" == "mac" ]]; then
          brew install unzip
        else
          sudo apt install -y unzip
        fi
      fi
      echo "==> Installing fnm..."
      curl -fsSL https://fnm.vercel.app/install | bash
    else
      echo "==> Skipping fnm installation"
    fi
  fi
else
  echo "==> fnm already installed"
fi

# ── Install you-should-use plugin ──────────────────────────────────────────
YSU_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/you-should-use"
if [[ ! -d "$YSU_DIR" ]]; then
  echo "==> Installing you-should-use plugin..."
  git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git "$YSU_DIR"
else
  echo "==> you-should-use already installed"
fi

# ── Fastfetch config ──────────────────────────────────────────────────────────
if command -v fastfetch &>/dev/null; then
  mkdir -p "$HOME/.config/fastfetch"
  case "$FASTFETCH_CHOICE" in
    2)
      cp "$DOTFILES_DIR/config/fastfetch/config-compact.jsonc" "$HOME/.config/fastfetch/config.jsonc"
      echo "   → fastfetch: compact theme"
      ;;
    *)
      cp "$DOTFILES_DIR/config/fastfetch/config-full.jsonc" "$HOME/.config/fastfetch/config.jsonc"
      echo "   → fastfetch: full theme"
      ;;
  esac
fi

# ── Link dotfiles ────────────────────────────────────────────────────────────
echo "==> Linking dotfiles..."
[[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]] && mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
[[ -f "$HOME/.p10k.zsh" && ! -L "$HOME/.p10k.zsh" ]] && mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.backup"

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# ── Configure git-delta ──────────────────────────────────────────────────────
if command -v delta &>/dev/null; then
  git config --global core.pager "delta"
  git config --global interactive.diffFilter "delta --color-only"
  git config --global delta.navigate true
  git config --global delta.light false
  git config --global merge.conflictStyle zdiff3
fi

# ── Set zsh as default shell (Mac) ──────────────────────────────────────────
if [[ "$OS" == "mac" ]] && [[ "$SHELL" != "$(command -v zsh)" ]]; then
  echo "==> Setting zsh as default shell..."
  chsh -s "$(command -v zsh)"
fi

echo ""
echo "✅ Done! Restart your terminal or run: source ~/.zshrc"
echo "   To customize prompt later: p10k configure"
echo "   Run with --minimal to skip optional tools (fastfetch, lazygit, lazydocker, git-delta, tldr)"
