# nix2vim — Nix to Neovim Configuration Framework

nix2vim is a framework that lets you configure Neovim entirely in **Nix**. It provides a declarative, type-safe way to define your Neovim setup — mappings, options, plugins, LSP clients, Treesitter grammars, and more — all from within the Nix expression language.

## Why nix2vim?

- **Declarative configuration** — Define your entire Neovim config as pure Nix data structures, no Lua required.
- **Reproducible** — Your editor setup is locked in a Nix flake, the same way you lock your system or project dependencies.
- **Composable modules** — Mix and match pre-built modules or write your own, just like NixOS or Home Manager.
- **Type-checked options** — Catch misconfigurations at build time thanks to Nix's module system.
- **Seamless Nix integration** — Use any package from nixpkgs as a plugin or dependency.

## How it works

nix2vim evaluates a Nix module (or set of modules) into a Lua configuration string, wraps it with a Neovim binary, and produces a **fully contained, reproducible Neovim derivation** — all from Nix.

The framework provides:

- **API options** — Mirror the Neovim Lua API (`vim.opt`, `vim.keymap.set`, etc.) as Nix attributes.
- **Wrapper options** — Control how the Neovim derivation is built (plugins, packages, aliases).
- **LSP options** — Declaratively configure `nvim-lspconfig` with language servers and custom `on_attach` hooks.
- **Treesitter options** — Set up Treesitter with grammars and highlight options.
- **A DSL** — A small embedded language for advanced Lua generation patterns (`dsl.callWith`, `dsl.rawLua`, etc.).

## Project Status

This project is actively developed. The module system is stable, and the option interfaces are maturing. See the [GitHub repository](https://github.com/gytis-ivaskevicius/nix2vim) for the latest updates.
