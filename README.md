# nix2vim
Nix to neovim lua configuration parser.

Getting started:
```bash
# Install unstable nix with flakes enabled https://github.com/numtide/nix-unstable-installer
sh <(curl -L https://github.com/numtide/nix-unstable-installer/releases/download/nix-2.9.0pre20220513_bf89cd9/install)

# Create repo with this project preinstalled
mkdir super-cool-neovim && cd super-cool-neovim
nix flake init --template github:gytis-ivaskevicius/nix2vim
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

