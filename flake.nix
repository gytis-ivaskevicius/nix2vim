{
  description = "nix2vim";

  inputs = {
    nixpkgs.url = github:gytis-ivaskevicius/nixpkgs;
  };

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib) mkApp mkApp' eachSystem systems;
      dsl = import ./lib/dsl.nix { inherit (nixpkgs) lib; };
      commonSystems = systems.supported.tier1 ++ systems.supported.tier2;

      overlay = final: prev: {

        nix2luaUtils = prev.callPackage ./lib/utils.nix { inherit nixpkgs; };

        neovimBuilder = import ./lib/neovim-builder.nix {
          pkgs = prev;
          lib = prev.lib;
        };

        nix2vimDemo = final.neovimBuilder {
          imports = [
            ./modules/essentials.nix
            ./modules/git.nix
            ./modules/lsp.nix
            ./modules/nvim-tree.nix
            ./modules/styling.nix
            ./modules/treesitter.nix
            ./modules/telescope.nix
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
    eachSystem commonSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        packages.default = pkgs.nix2vimDemo;

        # Check if correct path is selected
        apps.a = nixpkgs.lib.mkApp' pkgs.nix2vimDemo "vi";

        # Check if correct path is automagically selected
        apps.b = nixpkgs.lib.mkApp pkgs.nix2vimDemo;

        checks = import ./checks { inherit pkgs dsl; check-utils = import ./check-utils.nix; };
      }
    );

}
