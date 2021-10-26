{ lib }:

let
  inherit (builtins) isFunction isAttrs typeOf concatStringsSep substring elemAt length toJSON foldl' isList attrNames;
  nix2vim = "nix2vim";

  mapLuaTable = func: args:
    "{" + concatStringsSep ", " (map func args) + "}";

  nix2lua = (args:
    (if isList args then
      mapLuaTable nix2lua args
    else if isAttrs args && !(args ? type && args.type == "derivation") then
      mapLuaTable (it: "${it} = ${nix2lua args.${it}}") (attrNames args)
    else
      toJSON args));

  op = sum: path: val:
    let
      isCustomValue = val ? type && (val.type == nix2vim || val.type == "derivation");
      pathStr = concatStringsSep "." path;
    in
    if !(isAttrs val) || isCustomValue then
      (sum // { "${pathStr}" = val; })
    else if isFunction val then
      abort "Nix funcitons can not be parsed"
    else
      (recurse sum path val);

  recurse = sum: path: val:
    builtins.foldl'
      (sum: key: op sum (path ++ [ key ]) val.${key})
      sum
      (builtins.attrNames val);

  mkCustomType = subtype: content: {
    inherit subtype content;
    type = nix2vim;
  };
in
{
  inherit nix2lua;
  flatten = obj: recurse { } [ ] obj;
  toTable = content: mkCustomType "table" content;
  toFuncCall = content: mkCustomType "funcCall" content;
}
