{ pkgs, lib }:

with lib;
{ ... }@config:
let
  dsl = import ./dsl.nix { inherit lib; };
  result = evalModules {
    modules = [
      ./api.options.nix
      ./wrapper.options.nix
      ./treesitter.options.nix
      ./lsp.options.nix
      config
    ];
    specialArgs = { inherit pkgs dsl; };
  };
in
result.config.drv
