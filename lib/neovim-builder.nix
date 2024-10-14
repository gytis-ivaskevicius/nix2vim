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
        ai = ./modules/ai.nix;
        essentials = ./modules/essentials.nix;
        git = ./modules/git.nix;
        lsp = ./modules/lsp.nix;
        nvchad = ./modules/nvchad.nix;
        nvim-tree = ./modules/nvim-tree.nix;
        telescope = ./modules/telescope.nix;
        treesitter = ./modules/treesitter.nix;
        which-key = ./modules/which-key.nix;
      };
    };
  };
in
result.config.drv
