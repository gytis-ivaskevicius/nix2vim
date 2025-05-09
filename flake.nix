{
  description = "Next generation neovim configuration framework";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, flake-utils, nixpkgs }:
    let
      dsl = import ./lib/dsl.nix { inherit (nixpkgs) lib; };

      overlay = final: _: {

        nix2luaUtils = final.callPackage ./lib/utils.nix { inherit nixpkgs; };

        neovimBuilder = import ./lib/neovim-builder.nix {
          pkgs = final;
          lib = final.lib;
        };

        nix2vimDemo = final.neovimBuilder {
          imports = [
            ./modules/ai.nix
            ./modules/essentials.nix
            ./modules/git.nix
            ./modules/lsp.nix
            ./modules/nvchad.nix
            ./modules/nvim-tree.nix
            ./modules/telescope.nix
            ./modules/treesitter.nix
            ./modules/which-key.nix
            ./modules/ai.nix
          ];

          enableViAlias = true;
          enableVimAlias = true;
        };
      };


    in
    {
      inherit overlay;
      lib.dsl = dsl;
      templates.default = {
        path = ./template;
        description = "A very basic neovim configuration";
      };
    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ overlay ];
        };
      in
      {
        packages.default = pkgs.nix2vimDemo;
        apps = import ./apps.nix { inherit pkgs; utils = flake-utils.lib; };
        checks = import ./checks { inherit pkgs dsl; check-utils = import ./check-utils.nix; };
      }
    );

}
