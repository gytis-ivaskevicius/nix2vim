{
  description = "nix2vim";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, flake-utils, nixpkgs }:
    let
      dsl = import ./lib/dsl.nix { inherit (nixpkgs) lib; };

      overlay = prev: final: with prev; {
        utils = callPackage ./lib/utils.nix { inherit nixpkgs; };
        luaConfigBuilder = import ./lib/lua-config-builder.nix {
          pkgs = prev;
          lib = prev.lib;
        };
        neovimBuilder = import ./lib/neovim-builder.nix {
          pkgs = prev;
          lib = prev.lib;
        };
        neovimConfig = utils.makeNeovimConfig {
          python3 = python3;
          nodejs = nodejs;
          extraPython3Packages = pkgs: [ pkgs.requests ];
          extraLuaPackages = pkgs: with pkgs; [ luafilesystem ];
          plugins = with pkgs.vimPlugins; [ vim-nix nerdtree tagbar vim-clap vim-airline vim-airline-themes ];
          optionalPlugins = with pkgs.vimPlugins; [ ];
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
        packages = {
          default = pkgs.neovimBuilder {
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

        checks = import ./checks { inherit pkgs dsl; check-utils = import ./check-utils.nix; };
      }
    );

}
