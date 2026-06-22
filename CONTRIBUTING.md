# Contributing

Thanks for your interest in improving zsh-setup!

## How to Contribute

### Report a Bug

Open an [issue](https://github.com/alivinshiva/zsh-setup/issues) describing:
- What you expected to happen
- What actually happened
- Your OS and zsh version

### Suggest a Feature

Open an [issue](https://github.com/alivinshiva/zsh-setup/issues) with the `enhancement` label describing the feature and why it would be useful.

### Submit a Pull Request

1. Fork the repository.
2. Create a branch: `git checkout -b my-feature`.
3. Make your changes.
4. Test on both macOS and Linux if possible.
5. Push and open a PR.

### Code Style

- Keep `.zshrc` portable — check for macOS vs Linux with `$(uname)`.
- Source plugin files only if they exist (`[[ -f "$path" ]] && source "$path"`).
- Use the existing alias and naming conventions.

### Local Dev (UI)

```sh
cd ui
npm install
npm run dev
```

The UI site lives in `ui/` and is a Vite + React app. Build with `npm run build`.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
