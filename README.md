# zsh-setup

Portable Oh My Zsh + Powerlevel10k configuration with cross-platform aliases, plugins, and performance tweaks. Works on **macOS** and **Linux**.

## Installation

### One-liner (curl | sh)

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/alivinshiva/zsh-setup/master/install.sh)"
```

### Clone + run

```sh
git clone https://github.com/alivinshiva/zsh-setup.git
cd zsh-setup
./install.sh
```

The script handles everything automatically:
- Installs Oh My Zsh + Powerlevel10k theme
- Installs CLI tools (`eza`, `bat`, `fd`, `fzf`, `fastfetch`, `zoxide`, `neovim`, `gh`, `git-delta`, `tldr`, `lazygit`, `lazydocker`)
- Installs `zsh-autosuggestions`, `zsh-syntax-highlighting`, and `nvm`
- Configures `git-delta` as the default pager for syntax-highlighted diffs
- Symlinks `.zshrc` and `.p10k.zsh`
- Sets zsh as default shell (macOS)

## What's included

| Feature | Details |
|---|---|
| **Theme** | Powerlevel10k (classic style) |
| **Plugins** | git, docker, npm, node, gh, zoxide, extract, colored-man-pages, sudo, web-search, command-not-found, dirhistory |
| **History** | 50K lines, dedup, append, share across sessions |
| **Completions** | Menu selection, case-insensitive matching |
| **Aliases** | `ls` → `eza --classify`, `lt` → tree view, `ff` → fzf + bat preview, `g` → git, `d` → docker |
| **Utilities** | zoxide (smart `cd`), autosuggestions, syntax highlighting |
| **fzf** | `Ctrl+R` fuzzy history search, `Ctrl+T` fuzzy file search, `Alt+C` fuzzy cd |
| **Git** | `git-delta` pager with syntax-highlighted diffs, `git` plugin completions |
| **System info** | `fastfetch` on interactive shell start |
| **Portable** | Auto-detects Mac vs Linux paths and tool names |

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for fixes to common issues — config overwrites, missing tools, theme problems, and more.

## Customize

```sh
# Re-run the Powerlevel10k configuration wizard
p10k configure
```

Edit `~/.zshrc` or `~/.p10k.zsh` directly to fine-tune.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on reporting bugs, suggesting features, and submitting PRs.

## Website

A showcase site is available in the [`ui/`](ui) directory — a Vite + React app with a light/dark theme.
