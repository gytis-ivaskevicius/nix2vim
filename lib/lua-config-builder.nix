{ pkgs, lib }:

with lib;
{ config }:
let
  result = evalModules {
    modules = [
      ./api.options.nix
      ./treesitter.options.nix
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
