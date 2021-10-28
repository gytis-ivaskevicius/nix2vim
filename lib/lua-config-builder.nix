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
  dsl = import ./dsl.nix { inherit lib; };

  require = attrValues (mapAttrs (name: value: "require('${name}').${dsl.attrs2Lua value}") config.use);
in
{
  inherit result;
  lua = ''
    ${dsl.attrs2Lua { inherit (result.config) vim; }}
    ${concatStringsSep "" require}
  '';
}
