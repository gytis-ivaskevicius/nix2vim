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
              ./example.nix
            ];

            vimscript = ''
              colorscheme dracula
            '';


            plugins = with pkgs.vimPlugins; [
              # Adding reference to our custom plugin
              dracula-vim

              # Overwriting plugin sources with different version
              cmp-buffer
              telescope-nvim
              nvim-cmp
              cmp-nvim-lsp

              # Plugins from nixpkgs
              lsp_signature-nvim
              lspkind-nvim
              nerdcommenter
              nvim-lspconfig
              plenary-nvim
              popup-nvim

              # Compile syntaxes into treesitter
              (pkgs.vimPlugins.nvim-treesitter.withPlugins
                (plugins: with plugins; [ tree-sitter-nix tree-sitter-rust ]))
            ];

          };
        };

        checks = import ./checks { inherit pkgs dsl; check-utils = import ./check-utils.nix; };
      }
    );

}
