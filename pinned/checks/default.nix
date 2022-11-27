{ pkgs, lib ? pkgs.lib, dsl, check-utils }:
with check-utils pkgs;

let
  inherit (dsl) flatten flatAttrs2Lua nix2lua toTable callWith attrs2Lua;
  trace = it: builtins.trace it it;

  flatten1 = {
    a = 1;
    b = "b";
    c = true;
    d = [ 1 2 3 ];
    e = toTable { a = 1; b = { b = 2; }; };
    f = callWith { a = 1; };
    g = callWith [{ a = 1; } 1 "abc" true];
  };
  flatten2.a.a = { inherit (flatten1) a b c d e f; };

  complexTable = {
    a = 1;
    b = true;
    c = "c";
    d = [ 1 "a" { d = 1; } [ 1 ] ];
    e = {
      a = { a = 1; b = 2; };
      b = { a = 1; };
    };
  };
in
{

  flatten11 = isEqual (flatten flatten1) flatten1;
  flatten21 = isEqual (flatten flatten2) {
    "a.a.a" = flatten1.a;
    "a.a.b" = flatten1.b;
    "a.a.c" = flatten1.c;
    "a.a.d" = flatten1.d;
    "a.a.e" = flatten1.e;
    "a.a.f" = flatten1.f;
  };

  nix2lua = isEqual
    (nix2lua complexTable)
    ''{a = 1, b = true, c = "c", d = {1, "a", {d = 1}, {1}}, e = {a = {a = 1, b = 2}, b = {a = 1}}}'';

  attrs2Lua =
    let
      expected = (lib.removePrefix "\n" (builtins.readFile ./attrs2lua.lua));
      result = (attrs2Lua { a = flatten1; });
    in
    isEqual expected result;
}
