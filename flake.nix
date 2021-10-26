{
  description = "nix2vim";

  inputs = {
    flake-utils.url = "/home/gytis/Projects/flake-utils";
    nixpkgs.url = github:NixOS/nixpkgs;
  };

  outputs = { self, flake-utils, nixpkgs }:
    let
      dsl = import ./dsl.nix { inherit (nixpkgs) lib; };

      overlay = prev: final: with prev; {
        utils = callPackage ./utils.nix { inherit nixpkgs; };
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
        inherit (flake-utils.lib.check-utils system) isEqual hasKey;
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        defaultPackage = (overlay pkgs pkgs).config.pluginsScript;

        checks = with dsl;
          let
            flatten1 = {
              a = 1;
              b = "b";
              c = true;
              d = [ 1 2 3 ];
              e = toTable { a = 1; b = { b = 2; }; };
              f = toFuncCall { a = 1; };
            };
            flatten2.a.a = { inherit (flatten1) a b c d e f; };

            complexTable = {
              a = 1;
              b = true;
              c = "c";
              d = [ 1 "a" { d = 1; } [ 1 ] ];
              e = {
                a = { a = 1; b = 2; };
                b = { a = 1; };
              };
            };
            trace = it: builtins.trace it it;
          in
          {
            #b = (flatten a);
            flatten1 = isEqual (flatten flatten1) flatten1;
            flatten2 = isEqual (flatten flatten2) {
              "a.a.a" = flatten1.a;
              "a.a.b" = flatten1.b;
              "a.a.c" = flatten1.c;
              "a.a.d" = flatten1.d;
              "a.a.e" = flatten1.e;
              "a.a.f" = flatten1.f;
            };

            nix2lua = isEqual
              (trace (nix2lua complexTable))
              ''{a = 1, b = true, c = "c", d = {1, "a", {d = 1}, {1}}, e = {a = {a = 1, b = 2}, b = {a = 1}}}'';


          };
      }
    );

}
