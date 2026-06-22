# Troubleshooting

Common issues you might encounter during or after installation and how to fix them.

---

## My existing `.zshrc` / `.p10k.zsh` got overwritten

The install script **backs up** your existing files before symlinking the new ones.

```sh
# Restore your previous config
mv ~/.zshrc.backup ~/.zshrc
mv ~/.p10k.zsh.backup ~/.p10k.zsh
exec zsh
```

If the symlink already exists, remove it first:

```sh
rm ~/.zshrc ~/.p10k.zsh
mv ~/.zshrc.backup ~/.zshrc
mv ~/.p10k.zsh.backup ~/.p10k.zsh
exec zsh
```

---

## Command not found: eza / bat / fd / fastfetch

The tools may not have been installed correctly.

**macOS:**
```sh
brew install eza bat fd fzf fastfetch
```

**Linux (Debian/Ubuntu):**
```sh
sudo apt install eza bat fd-find fzf fastfetch
# fastfetch may need a PPA:
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y && sudo apt update && sudo apt install fastfetch
```

**Note:** On Linux, the binaries are sometimes named differently:
- `bat` → `batcat` (the `.zshrc` handles this automatically)
- `fd` → `fdfind` (handled automatically)

---

## Powerlevel10k prompt not showing

**Check that the theme is installed:**
```sh
ls ~/.oh-my-zsh/custom/themes/powerlevel10k
```

If missing, install it:
```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
```

**Check that `ZSH_THEME` is set correctly in `.zshrc`:**
```sh
grep ZSH_THEME ~/.zshrc
# Should output: ZSH_THEME="powerlevel10k/powerlevel10k"
```

**Re-run the configuration wizard:**
```sh
p10k configure
```

**Font issue:** Powerlevel10k needs a Nerd Font or powerline-patched font. Install one:
- [Meslo Nerd Font](https://github.com/romkatv/powerlevel10k#fonts) (recommended)
- Then set it in your terminal emulator settings.

---

## zsh-syntax-highlighting not working

**Check the file exists:**
```sh
# macOS (Homebrew)
ls /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Linux
ls /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

If missing, install it:
```sh
# macOS
brew install zsh-syntax-highlighting
# Linux
sudo apt install zsh-syntax-highlighting
```

**Ensure it loads last** — the `source` line must be at the very end of `~/.zshrc` (the install script handles this).

---

## zsh-autosuggestions not working

**Check the file exists:**
```sh
# macOS (Homebrew)
ls /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Linux
ls /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
```

If missing:
```sh
# macOS
brew install zsh-autosuggestions
# Linux
sudo apt install zsh-autosuggestions
```

---

## NVM not working

**Check NVM is installed:**
```sh
ls ~/.nvm
```

If missing, install it:
```sh
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

**Restart your terminal** or run:
```sh
source ~/.zshrc
```

**Verify:**
```sh
command -v nvm
```

---

## fzf key bindings not working (Ctrl+R, Ctrl+T, Alt+C)

**Check fzf is installed:**
```sh
fzf --version
```

If missing:
```sh
# macOS
brew install fzf
# Linux
sudo apt install fzf
```

**Check the key binding files exist:**
```sh
ls /usr/share/fzf/key-bindings.zsh   # Linux
ls /opt/homebrew/opt/fzf/shell/key-bindings.zsh  # macOS
```

---

## Oh My Zsh not installed

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

---

## Permission errors on Linux during installation

The install script uses `sudo` for apt installs. If you see permission errors:

```sh
# Run the individual commands manually
sudo apt update
sudo apt install zsh-autosuggestions zsh-syntax-highlighting zoxide eza bat fd-find fzf gh git-delta tldr neovim
```

---

## git-delta not showing syntax-highlighted diffs

**Check delta is installed:**
```sh
delta --version
```

If missing:
```sh
# macOS
brew install git-delta
# Linux
sudo apt install git-delta
```

**Re-apply the git config:**
```sh
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
```

---

## `fastfetch` not showing system info on terminal start

**Check it's installed:**
```sh
fastfetch --version
```

If missing:
```sh
# macOS
brew install fastfetch
# Linux
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
sudo apt update
sudo apt install fastfetch
```

**Note:** `fastfetch` only runs in interactive shells. If you're using a non-interactive shell (e.g., running a script), it won't show.

---

## Still having trouble?

Open an [issue](https://github.com/alivinshiva/zsh-setup/issues) with:
- Your OS and version
- The exact error message
- What you've tried so far
