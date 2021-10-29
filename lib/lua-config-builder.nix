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

  require = flatten (mapAttrsToList (name: value: mapAttrsToList (name_inner: value_inner: "require('${name}').${dsl.attrs2Lua {name_inner = value_inner; }}") value) result.config.use);
in
{
  inherit result;
  lua = ''
    ${dsl.attrs2Lua { inherit (result.config) vim; }}
    ${concatStringsSep "" require}
    ${result.config.lua}
  '';
}
