# Quick Start

## Prerequisites

- [Nix](https://nixos.org/download.html) with [flakes](https://nixos.wiki/wiki/Flakes) enabled.

## Create a new config from the template

```bash
mkdir my-neovim-config && cd my-neovim-config
nix flake init --template github:gytis-ivaskevicius/nix2vim
```

This creates a minimal `flake.nix` with nix2vim as an input and a sample module.

## Build and run

```bash
nix run .
```

## Customise

Add modules, configure LSP clients, set up Treesitter — everything is declarative Nix:

```nix
{
  imports = [ ./modules/telescope.nix ];

  set.termguicolors = true;
  nnoremap."<leader>/" = ":nohl<cr>";

  plugins = with pkgs.vimPlugins; [ dracula-vim ];
}
```

See the [Configuration](./configuration.md) page for all available options.
