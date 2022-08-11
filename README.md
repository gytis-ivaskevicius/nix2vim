<h1 align="center">
  <img src="https://user-images.githubusercontent.com/13730968/184056986-6c74e9d4-dc35-4f39-a0bb-dc4d3ac5125c.png" alt="Skooter">
</h1>

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

![deploying](https://github.com/DieracDelta/DieracDelta.github.io/workflows/Build/badge.svg)


# Skooter
Nix to neovim lua configuration parser.

Getting started:
```bash
# Install unstable nix with flakes enabled https://github.com/numtide/nix-unstable-installer
sh <(curl -L https://github.com/numtide/nix-unstable-installer/releases/download/nix-2.9.0pre20220513_bf89cd9/install)

# Create repo with this project preinstalled
mkdir super-cool-neovim && cd super-cool-neovim
nix flake init --template github:gytis-ivaskevicius/skooter
nix run .
```

Available options:
- [Neovim lua api options](./docs/api.options.md)
- [Neovim wrapper options](./docs/wrapper.options.md)

Usage examples:
- https://github.com/DieracDelta/vimconfig
- `./modules` folder

TODO:
- Improve docs
- Add standalone lua config builder (without neovim)
- Find a better project name (Looking for suggestions!)

