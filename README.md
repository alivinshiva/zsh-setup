# zsh-setup

Portable Oh My Zsh + Powerlevel10k configuration with cross-platform aliases, plugins, and performance tweaks. Works on **macOS** and **Linux**.

## Installation

### One-liner (curl | sh)

```sh
curl -fsSL https://raw.githubusercontent.com/alivinshiva/zsh-setup/master/install.sh | sh
```

### Clone + run

```sh
git clone https://github.com/alivinshiva/zsh-setup.git
cd zsh-setup
./install.sh
```

The script handles everything automatically:
- Installs Oh My Zsh + Powerlevel10k theme
- Installs CLI tools (`eza`, `bat`, `fd`, `fzf`, `fastfetch`, `zoxide`, `neovim`, `lazygit`, `lazydocker`)
- Installs `zsh-autosuggestions` and `zsh-syntax-highlighting`
- Symlinks `.zshrc` and `.p10k.zsh`
- Sets zsh as default shell (macOS)

## What's included

| Feature | Details |
|---|---|
| **Theme** | Powerlevel10k (classic style) |
| **Plugins** | git, docker, npm, node, gh, zoxide, extract, colored-man-pages, sudo, web-search, command-not-found, dirhistory |
| **History** | 50K lines, dedup, append, share across sessions |
| **Completions** | Menu selection, case-insensitive matching |
| **Aliases** | `ls` → `eza --classify`, `lt` → tree view, `ff` → fzf preview, `g` → git, `d` → docker |
| **Utilities** | zoxide (smart `cd`), autosuggestions, syntax highlighting |
| **System info** | `fastfetch` on interactive shell start |
| **Portable** | Auto-detects Mac vs Linux paths and tool names |

## Customize

```sh
# Re-run the Powerlevel10k configuration wizard
p10k configure
```

Edit `~/.zshrc` or `~/.p10k.zsh` directly to fine-tune.
