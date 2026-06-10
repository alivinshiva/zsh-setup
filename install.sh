#!/usr/bin/env bash
set -euo pipefail

# ─── zsh-setup ──────────────────────────────────────────────────────────────
# Installs Oh My Zsh + Powerlevel10k + plugins + dotfiles on a fresh Mac/Linux
# ──────────────────────────────────────────────────────────────────────────────

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing zsh setup from $DOTFILES_DIR"

# ── Detect platform ──────────────────────────────────────────────────────────
if [[ "$(uname)" == "Darwin" ]]; then
  OS="mac"
  # Ensure Homebrew
  if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
else
  OS="linux"
fi

# ── Install tools ────────────────────────────────────────────────────────────
echo "==> Installing tools..."

if [[ "$OS" == "mac" ]]; then
  brew install \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    powerlevel10k \
    zoxide \
    eza \
    bat \
    fd \
    fzf \
    fastfetch \
    neovim \
    coreutils \
    lazygit \
    lazydocker
elif [[ "$OS" == "linux" ]]; then
  echo "Linux detected — skipping brew installs."
  echo "Make sure these are installed via your package manager:"
  echo "  zsh-autosuggestions zsh-syntax-highlighting zoxide eza bat fdfind fzf fastfetch neovim lazygit lazydocker"
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

# ── Install OMZ plugins (custom, not built-in) ──────────────────────────────
install_omz_plugin() {
  local name="$1"
  local url="$2"
  local dest="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$name"
  if [[ ! -d "$dest" ]]; then
    echo "==> Installing OMZ plugin: $name"
    git clone --depth=1 "$url" "$dest"
  else
    echo "==> OMZ plugin $name already installed"
  fi
}

# Built-in plugins (git, docker, npm, node, gh, zoxide, extract, etc.) ship
# with Oh My Zsh — no extra install needed. Only custom plugins below:
# (none currently required — all our plugins are OMZ built-ins)

# ── Link dotfiles ────────────────────────────────────────────────────────────
echo "==> Linking dotfiles..."

# Backup existing
[[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]] && mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
[[ -f "$HOME/.p10k.zsh" && ! -L "$HOME/.p10k.zsh" ]] && mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.backup"

ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# ── Set zsh as default shell (Mac) ──────────────────────────────────────────
if [[ "$OS" == "mac" ]]; then
  if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "==> Setting zsh as default shell..."
    chsh -s "$(which zsh)"
  fi
fi

echo ""
echo "✅ Done! Restart your terminal or run: source ~/.zshrc"
echo "   To customize prompt later: p10k configure"
