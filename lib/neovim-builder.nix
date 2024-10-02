{ pkgs, lib }:

with lib;
{ ... }@config:
let
  dsl = import ./dsl.nix { inherit lib; };
  result = evalModules {
    modules = [
      ./api.options.nix
      ./wrapper.options.nix
      ./treesitter.options.nix
      ./lsp.options.nix
      config
    ];
    specialArgs = {
      inherit pkgs dsl;
      modules = {
        nvchad = ./modules/nvchad.nix;
        essentials = ./modules/essentials.nix;
        git = ./modules/git.nix;
        lsp = ./modules/lsp.nix;
        nvim-tree = ./modules/nvim-tree.nix;
        treesitter = ./modules/treesitter.nix;
        telescope = ./modules/telescope.nix;
        which-key = ./modules/which-key.nix;
      };
    };
  };
in
result.config.drv
