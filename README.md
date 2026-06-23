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

You'll be prompted to choose between **Full** and **Minimal** install. Use `--minimal` for non-interactive mode.

### What gets installed

| Mode | Tools |
|------|-------|
| **Full** (default) | zsh-autosuggestions, zsh-syntax-highlighting, zoxide, eza, bat, fd, fzf, gh, neovim, fastfetch, git-delta, tldr, lazygit, lazydocker |
| **Minimal** (`--minimal`) | zsh-autosuggestions, zsh-syntax-highlighting, zoxide, eza, bat, fd, fzf, gh, neovim |

The script also installs:
- **Oh My Zsh** + **Powerlevel10k** theme
- **NVM** (Node Version Manager)
- **fnm** (Fast Node Manager) — prompted only if Node.js is not detected
- **you-should-use** — warns when you type a command that has an alias
- Configures `git-delta` as default pager
- Symlinks `.zshrc` and `.p10k.zsh`
- Sets zsh as default shell (macOS)

## Uninstall

```sh
curl -fsSL https://raw.githubusercontent.com/alivinshiva/zsh-setup/master/uninstall.sh | bash
```

Removes symlinks, restores backups (`.zshrc.backup`, `.p10k.zsh.backup`). Oh My Zsh and installed tools are left intact.

## What's included

| Feature | Details |
|---|---|
| **Theme** | Powerlevel10k (classic style) |
| **Plugins** | git, docker, npm, node, gh, zoxide, extract, colored-man-pages, sudo, web-search, command-not-found, dirhistory, history-substring-search, you-should-use |
| **History** | 50K lines, dedup, append, share across sessions. ↑/↓ searches by typed prefix |
| **Completions** | Menu selection, case-insensitive matching |
| **Aliases** | `ls` → `eza --classify`, `lt` → tree view, `ff` → fzf + bat preview, `g` → git, `d` → docker, `lg` → lazygit, `ld` → lazydocker, `mkcd` → mkdir + cd |
| **Node** | NVM + fnm (auto-detects .nvmrc). fnm skipped if node already installed |
| **Utilities** | zoxide (smart `cd`), autosuggestions, syntax highlighting, alias reminders |
| **fzf** | `Ctrl+R` fuzzy history search, `Ctrl+T` fuzzy file search, `Alt+C` fuzzy cd |
| **Git** | `git-delta` pager with syntax-highlighted diffs, `git` plugin completions |
| **System info** | `fastfetch` on interactive shell start (full or compact theme) |
| **Portable** | Auto-detects Mac vs Linux paths and tool names |

## Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for fixes to common issues — config overwrites, missing tools, theme problems, and more.

## Customize

```sh
# Re-run the Powerlevel10k configuration wizard
p10k configure
```

Edit `~/.zshrc` or `~/.p10k.zsh` directly to fine-tune.

## Showcase

- **Website**: [zsh-setup-ui](https://github.com/alivinshiva/zsh-setup-ui) — Vite + React app with TUI aesthetic, live demo, and docs
- **Badge**: Add to your README ([POWERED_BY.md](POWERED_BY.md))

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details on reporting bugs, suggesting features, and submitting PRs.
