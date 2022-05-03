{
  description = "nix2vim";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, flake-utils, nixpkgs }:
    let
      dsl = import ./lib/dsl.nix { inherit (nixpkgs) lib; };


      overlay = prev: final: {

        nix2luaUtils = prev.callPackage ./lib/utils.nix { inherit nixpkgs; };

        neovimBuilder = import ./lib/neovim-builder.nix {
          pkgs = prev;
          lib = prev.lib;
        };

        nix2vimDemo = prev.neovimBuilder {
          imports = [
            ./modules/essentials.nix
            ./modules/essentials.nix
            ./modules/git.nix
            ./modules/lsp.nix
            ./modules/nvim-tree.nix
            ./modules/styling.nix
            ./modules/treesitter.nix
            ./modules/telescope.nix
          ];
        };
      };


    in
    {
      inherit overlay;
      lib.dsl = dsl;
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        packages.default = pkgs.nix2vimDemo;

        checks = import ./checks { inherit pkgs dsl; check-utils = import ./check-utils.nix; };
      }
    );

}
