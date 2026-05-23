# Examples

## Minimal Config

```nix
{
  description = "My Neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nix2vim.url = "github:gytis-ivaskevicius/nix2vim";
  };

  outputs = { self, nixpkgs, nix2vim }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; overlays = [ nix2vim.overlay ]; };
  in {
    packages.${system}.default = pkgs.neovimBuilder {
      set = { termguicolors = true; number = true; };
      nnoremap."<leader>/" = ":nohl<cr>";
      plugins = with pkgs.vimPlugins; [ dracula-vim ];
    };
  };
}
```

## Full Demo

The `nix2vimDemo` package (default build) imports all built-in modules:

```bash
nix build .   # or nix run .
```
