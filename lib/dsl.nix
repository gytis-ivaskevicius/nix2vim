{ lib }:

let
  inherit (builtins) mapAttrs isFunction isAttrs typeOf concatStringsSep substring elemAt length toJSON foldl' isList attrNames;
  nix2vim = "nix2vim";
  trace = it: builtins.trace it it;

  typeConverters = {
    "" = name: it: "${name} = ${nix2lua it}";
    rawLua = name: it: "${name} = ${it}";
    table = name: it: "${name} = ${nix2lua it}";
    callWith = name: it:
      let
        value =
          if isAttrs it then
            nix2lua it
          else if isList it then
            concatStringsSep ", " (map nix2lua it)
          else
            toJSON it;
      in
      "${name}(${value})";
  };

  flatAttrs2Lua = flattened:
    foldl'
      (sum: name:
        let it = flattened.${name}; in
        sum + typeConverters.${it.subtype or ""} name (it.content or it) + "\n"
      )
      ""
      (attrNames flattened);

  mapLuaTable = func: args:
    "{" + concatStringsSep ", " (map func args) + "}";

  nix2lua = (args:
    (if isList args then
      mapLuaTable nix2lua args
    else if isAttrs args && !(args ? type && args.type == "derivation") then
    # HACK how content is handled should be matched based on subtype
      mapLuaTable (it: "${it} = ${args.${it}.content or (nix2lua args.${it})}") (attrNames args)
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
    foldl'
      (sum: key: op sum (path ++ [ key ]) val.${key})
      sum
      (builtins.attrNames val);

  mkCustomType = subtype: content: {
    inherit subtype content;
    type = nix2vim;
  };
in
rec {
  inherit nix2lua flatAttrs2Lua;
  attrs2Lua = attrs: flatAttrs2Lua (flatten attrs);
  flatten = obj: recurse { } [ ] obj;
  toTable = content: mkCustomType "table" content;
  callWith = content: mkCustomType "callWith" content;
  rawLua = content: mkCustomType "rawLua" content;
}
