{ pkgs, lib }:

{ config }:
let
  result = lib.evalModules {
    modules = [
      (import ./api.options.nix)
      config
    ];
    specialArgs = { inherit pkgs; };
  };
  dsl = import ./dsl.nix { inherit lib; };
in {
  inherit result;
  lua = dsl.attrs2Lua { inherit (result.config) vim; };
}
