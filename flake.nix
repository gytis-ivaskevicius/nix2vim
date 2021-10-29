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

        dsl = import ./lib/dsl.nix { inherit (pkgs) lib; };
        luaConfig = pkgs.luaConfigBuilder {
          config = import ./example.nix { inherit pkgs dsl; };
        };
      in
      {

        defaultPackage = pkgs.writeText "init.lua" luaConfig.lua;

        checks = import ./checks { inherit pkgs dsl; check-utils = import ./check-utils.nix; };
      }
    );

}
