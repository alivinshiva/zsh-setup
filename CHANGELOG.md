# Changelog

All notable changes to zsh-setup will be documented here.

## [1.2.0] - 2026-06-22

### Added
- `zsh-history-substring-search` plugin — press ↑/↓ to search history by typed prefix
- `you-should-use` plugin — warns when you type a command that has an alias
- `fnm` (Fast Node Manager) support — faster alternative to NVM
- `mkcd` function — create a directory and cd into it in one step
- `lg` and `ld` aliases for lazygit / lazydocker
- `--minimal` flag for install.sh — skips optional tools (fastfetch, lazygit, lazydocker, git-delta, tldr)
- `uninstall.sh` script — cleanly removes symlinks and restores backups
- `POWERED_BY.md` — badge for users to show they use zsh-setup
- Showcase website: GitHub star counter, Twitter/X share button, comparison table, FAQ, changelog, screenshots gallery

## [1.1.0] - 2026-06-20

### Added
- Showcase website `ui/` with TUI aesthetic, animated terminal demo, usage guide, troubleshooting
- `CONTRIBUTING.md` and `TROUBLESHOOTING.md`
- `git-delta` configuration for syntax-highlighted diffs
- `dirhistory` plugin for directory navigation

## [1.0.0] - 2026-06-18

### Added
- Initial release
- Oh My Zsh + Powerlevel10k setup
- zsh-autosuggestions, zsh-syntax-highlighting
- zoxide, eza, bat, fd, fzf integration
- Cross-platform support (macOS + Linux)
- NVM installation
- Curl one-liner install
