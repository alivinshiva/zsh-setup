#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/alivinshiva/zsh-setup.git"

# ── Detect mode: piped via curl or run locally ──────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || true)"
if [[ -f "$SCRIPT_DIR/.zshrc" ]]; then
  DOTFILES_DIR="$SCRIPT_DIR"
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
if [[ "$OS" == "mac" ]]; then
  echo "==> Installing tools via Homebrew..."
  brew install \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zoxide \
    eza \
    bat \
    fd \
    fzf \
    fastfetch \
    neovim \
    coreutils \
    gh \
    lazygit \
    lazydocker
elif [[ "$OS" == "linux" ]]; then
  echo "==> Installing tools via apt..."
  sudo apt update -qq
  sudo apt install -y \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    zoxide \
    eza \
    bat \
    fdfind \
    fzf \
    fastfetch \
    gh \
    neovim \
    lazygit
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

# ── Install NVM (Node Version Manager) ──────────────────────────────────────
if [[ ! -d "$HOME/.nvm" ]]; then
  echo "==> Installing NVM..."
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "==> NVM already installed"
fi

# ── Link dotfiles ────────────────────────────────────────────────────────────
echo "==> Linking dotfiles..."
[[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]] && mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
[[ -f "$HOME/.p10k.zsh" && ! -L "$HOME/.p10k.zsh" ]] && mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.backup"

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# ── Set zsh as default shell (Mac) ──────────────────────────────────────────
if [[ "$OS" == "mac" ]] && [[ "$SHELL" != "$(command -v zsh)" ]]; then
  echo "==> Setting zsh as default shell..."
  chsh -s "$(command -v zsh)"
fi

echo ""
echo "✅ Done! Restart your terminal or run: source ~/.zshrc"
echo "   To customize prompt later: p10k configure"
