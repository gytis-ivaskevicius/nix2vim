# Modules

## Built-in Modules

| Module | Description |
|--------|-------------|
| Essentials | Sensible defaults and quality-of-life settings |
| Git | Git integration (vim-fugitive, gitsigns) |
| LSP | Language Server Protocol configuration |
| NvChad | NvChad-like UI and theme |
| NvimTree | File explorer sidebar |
| Rust | Rust-specific tooling |
| Telescope | Fuzzy finder |
| Treesitter | Treesitter highlighting |
| WhichKey | Keybinding popup helper |

Import via `imports`:

```nix
{ imports = [ ./modules/telescope.nix ./modules/treesitter.nix ]; }
```

## Writing Custom Modules

```nix
# my-module.nix
{ config, lib, pkgs, dsl, ... }:
with lib;
let cfg = config.my-module; in {
  options.my-module.enable = mkEnableOption "My feature";
  config = mkIf cfg.enable {
    nnoremap."<leader>g" = ":echo 'hello'<cr>";
  };
}
```
