{
  description = "nix2vim";

  inputs = {
    flake-utils.url = "/home/gytis/Projects/flake-utils";
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, flake-utils, nixpkgs }:
    let
      dsl = import ./lib/dsl.nix { inherit (nixpkgs) lib; };

      overlay = prev: final: with prev; {
        utils = callPackage ./lib/utils.nix { inherit nixpkgs; };
        config = utils.makeNeovimConfig {
          python3 = python3;
          nodejs = nodejs;
          extraPython3Packages = pkgs: [ pkgs.requests ];
          extraLuaPackages = pkgs: with pkgs; [ luafilesystem ];
          plugins = with pkgs.vimPlugins; [ vim-nix nerdtree tagbar vim-clap vim-airline vim-airline-themes ];
          optionalPlugins = with pkgs.vimPlugins; [ ];
        };
      };


    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
        luaConfigBuilder = import ./lib/lua-config-builder.nix { inherit pkgs; lib = pkgs.lib; };
        dsl = import ./lib/dsl.nix { inherit (pkgs) lib; };

        luaConfig = luaConfigBuilder {
          config = import ./example.nix { inherit pkgs dsl; };
        };
      in
      {
        defaultPackage = pkgs.writeText "init.lua" luaConfig.lua;

        checks = import ./checks { inherit pkgs dsl; inherit (flake-utils.lib) check-utils; };
      }
    );

}
