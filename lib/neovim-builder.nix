{ pkgs, lib }:

with lib;
{ ... }@config:
let
  dsl = import ./dsl.nix { inherit lib; };
  result = evalModules {
    modules = [
      (import ./api.options.nix)
      (import ./wrapper.options.nix)
      config
    ];
    specialArgs = { inherit pkgs dsl; };
  };
in
result.config.drv
