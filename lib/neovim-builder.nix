{ pkgs, lib }:

with lib;
{ ... }@config:
let
  dsl = import ./dsl.nix;
  result = evalModules {
    modules = [
      ./api.options.nix
      ./wrapper.options.nix
      config
    ];
    specialArgs = { inherit pkgs dsl; };
  };
in
result.config.drv
