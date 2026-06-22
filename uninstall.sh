#!/usr/bin/env bash
set -euo pipefail

echo "==> zsh-setup Uninstaller"
echo "    This will remove zsh-setup dotfiles and restore your backups."
echo "    Oh My Zsh, Powerlevel10k, and tools (brew/apt packages) are NOT removed."
echo ""
read -p "Continue? [y/N] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

echo ""
echo "==> Removing symlinks..."
[[ -L "$HOME/.zshrc" ]] && rm "$HOME/.zshrc" && echo "  → Removed ~/.zshrc symlink"
[[ -L "$HOME/.p10k.zsh" ]] && rm "$HOME/.p10k.zsh" && echo "  → Removed ~/.p10k.zsh symlink"

echo ""
echo "==> Restoring backups..."
[[ -f "$HOME/.zshrc.backup" ]] && mv "$HOME/.zshrc.backup" "$HOME/.zshrc" && echo "  → Restored ~/.zshrc from backup"
[[ -f "$HOME/.p10k.zsh.backup" ]] && mv "$HOME/.p10k.zsh.backup" "$HOME/.p10k.zsh" && echo "  → Restored ~/.p10k.zsh from backup"

echo ""
echo "✅ Uninstall complete. Restart your terminal or run: exec zsh"
echo "   To fully remove Oh My Zsh: rm -rf ~/.oh-my-zsh"
echo "   To remove NVM: rm -rf ~/.nvm"
echo "   To remove fnm: rm -rf ~/.local/share/fnm && remove fnm eval from .zshrc"
