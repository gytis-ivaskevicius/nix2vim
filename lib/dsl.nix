{ lib }:
with lib;
let
  inherit (builtins) typeOf toJSON;
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

  nix2lua = args:
    if (args.type or null) == nix2vim then
      let
        subtypes = {
          "" = throw "No method to crate lua from ${args.subtype}";
          callWith = throw "Cannot perform callWith within a structure";
          rawLua = args.content;
          table = nix2lua args.content;
        };
      in
      subtypes.${args.subtype or ""}
    else if isList args then
      "{" + concatMapStringsSep ", " nix2lua args + "}"
    else if isAttrs args && (args.type or null) != "derivation" then
      "{" + concatMapStringsSep ", " (it: "${it} = ${nix2lua args.${it}}") (attrNames args) + "}"
    else
      toJSON args;

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
