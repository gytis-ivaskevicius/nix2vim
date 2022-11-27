{
  description = "Next generation neovim configuration framework";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs.url = github:NixOS/nixpkgs;
    root.url = path:../;
  };

  outputs = { self, flake-utils, nixpkgs, root }:
    let
      overlay = _: prev:
        let
          neovimBuilder = root.blueprints.neovimBuilder {
            pkgs = prev;
            lib = prev.lib;
          };
        in
        {
          inherit neovimBuilder;

          nix2luaUtils = prev.callPackage root.blueprints.nix2luaUtils { inherit nixpkgs; };

          nix2vimDemo = root.blueprints.nix2vimDemo { inherit neovimBuilder; };
        };


    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        packages.default = pkgs.nix2vimDemo;
        apps = import ./apps.nix {
          inherit pkgs;
          _lib = root.lib;
        };
        checks = import ./checks {
          inherit pkgs;
          inherit (root.lib) dsl;
          check-utils = import ./check-utils.nix;
        };
      }
    );

}
