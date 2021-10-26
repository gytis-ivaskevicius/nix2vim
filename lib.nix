{ lib }:

let
  inherit (builtins) isAttrs typeOf concatStringsSep substring elemAt length toJSON foldl' isList attrNames;

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
      firstChar = substring 0 1 (elemAt path (length path - 1));

      isFunctionCall = firstChar == "_";
      pathStr = builtins.concatStringsSep "." path;
    in
    if (builtins.typeOf val) != "set" || isFunctionCall then
      (sum // {
        "${pathStr}" = nix2lua val;
      })
    else if true then
    # builtins.trace "${pathStr} is a recursive"
    # recurse into that attribute set
      (recurse sum path val)
    else
    # ignore that value
    # builtins.trace "${pathStr} is something else"
      sum
  ;

  recurse = sum: path: val:
    builtins.foldl'
      (sum: key: op sum (path ++ [ key ]) val.${key})
      sum
      (builtins.attrNames val);
in
{
  toVimOptions = obj: recurse { } [ ] obj;
}
