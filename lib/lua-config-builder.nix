{ pkgs, lib }:

with lib;
{ config }:
let
  result = evalModules {
    modules = [
      (import ./api.options.nix)
      config
    ];
    specialArgs = { inherit pkgs; };
  };
in
{
  inherit result;
  lua = ''
    ${result.config.lua}
  '';
}
