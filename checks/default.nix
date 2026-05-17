{ pkgs, lib ? pkgs.lib, dsl, check-utils }:
with check-utils pkgs;

let
  inherit (dsl) flatten flatAttrs2Lua nix2lua toTable rawLua callWith attrs2Lua;

  # === Test data (existing) ===
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

  tableWithCustomTypes = {
    a.a = callWith {
      a = rawLua "some code";
      b = [
        (rawLua "1")
        (rawLua "2")
      ];
      c.a = toTable {
        a = rawLua "someVar";
      };
    };
  };

  # === Lua syntax check helper ===
  # Writes generated lua to a file and validates it with lua's parser
  luaSyntaxCheck = name: luaCode:
    let
      luaFile = pkgs.writeText "${name}.lua" luaCode;
    in
    pkgs.runCommand "lua-syntax-${name}" {
      buildInputs = [ pkgs.lua ];
    } ''
      ${pkgs.lua}/bin/lua -e 'assert(loadfile("${luaFile}"))'
      echo "success" > $out
    '';

  # === Config evaluator ===
  # Evaluates a nix2vim config via the module system and returns the generated lua
  evalLua = config:
    let
      result = pkgs.lib.evalModules {
        modules = [
          ../lib/api.options.nix
          ../lib/wrapper.options.nix
          ../lib/treesitter.options.nix
          ../lib/lsp.options.nix
          config
        ];
        specialArgs = {
          inherit pkgs dsl;
        };
      };
    in
      result.config.lua;

in
{

  # =====================================================
  # 1. DSL UNIT TESTS — Core function correctness
  # =====================================================

  # ---------- flatten ----------

  flatten11 = isEqual (flatten flatten1) flatten1;
  flatten21 = isEqual (flatten flatten2) {
    "a.a.a" = flatten1.a;
    "a.a.b" = flatten1.b;
    "a.a.c" = flatten1.c;
    "a.a.d" = flatten1.d;
    "a.a.e" = flatten1.e;
    "a.a.f" = flatten1.f;
  };
  flattenEmpty   = isEqual (flatten { }) { };
  flattenDeep    = isEqual (flatten { a.b.c.d.e.f.g.h.i.j.k = 1; }) { "a.b.c.d.e.f.g.h.i.j.k" = 1; };
  flattenShallow = isEqual (flatten { a = 1; }) { a = 1; };
  flattenNull    = isEqual (flatten { a.b = null; }) { "a.b" = null; };

  # ---------- nix2lua ----------

  nix2luaAll = isEqual
    (nix2lua complexTable)
    "{a = 1, b = true, c = \"c\", d = {1, \"a\", {d = 1}, {1}}, e = {a = {a = 1, b = 2}, b = {a = 1}}}";

  nix2luaEmptyAttrs  = isEqual (nix2lua { }) "{}";
  nix2luaEmptyList   = isEqual (nix2lua [ ]) "{}";
  nix2luaNull        = isEqual (nix2lua { a = null; }) "{a = null}";
  nix2luaMixedList   = isEqual (nix2lua [ 1 "a" true null [ ] ]) "{1, \"a\", true, null, {}}";
  nix2luaBoolTrue    = isEqual (nix2lua true) "true";
  nix2luaBoolFalse   = isEqual (nix2lua false) "false";
  nix2luaInt         = isEqual (nix2lua 42) "42";
  nix2luaFloat       = isEqual (nix2lua 3.14) "3.14";
  nix2luaString      = isEqual (nix2lua "hello") "\"hello\"";
  nix2luaNestedList  = isEqual (nix2lua [[1 2] [3 4]]) "{{1, 2}, {3, 4}}";
  nix2luaNestedAttrs = isEqual (nix2lua { a = { b = { c = 1; }; }; }) "{a = {b = {c = 1}}}";

  # ---------- rawLua ----------

  rawLuaAtTop    = isEqual (nix2lua (rawLua "vim.cmd('hello')")) "vim.cmd('hello')";
  rawLuaInAttrs  = isEqual (attrs2Lua { a = rawLua "someVar"; }) "a = someVar\n";
  rawLuaEmpty    = isEqual (nix2lua (rawLua "")) "";

  # ---------- toTable ----------

  toTableSimple  = isEqual (nix2lua (toTable { a = 1; })) "{a = 1}";
  toTableNested  = isEqual (nix2lua (toTable { a = { b = 1; }; })) "{a = {b = 1}}";
  toTableEmpty   = isEqual (nix2lua (toTable { })) "{}";

  # ---------- callWith ----------

  callWithAttrs  = isEqual (attrs2Lua { a = callWith { x = 1; y = "z"; }; }) "a({x = 1, y = \"z\"})\n";
  callWithList   = isEqual (attrs2Lua { a = callWith [ 1 2 3 ]; }) "a(1, 2, 3)\n";
  callWithScalar = isEqual (attrs2Lua { a = callWith 42; }) "a(42)\n";
  callWithNull   = isEqual (attrs2Lua { a = callWith null; }) "a(null)\n";
  callWithString = isEqual (attrs2Lua { a = callWith "hello"; }) "a(\"hello\")\n";

  # ---------- attrs2Lua full pipeline ----------

  attrs2Lua =
    let
      expected = (lib.removePrefix "\n" (builtins.readFile ./attrs2lua.lua));
      result = (attrs2Lua { a = flatten1; });
    in
    isEqual expected result;

  deepCustomTypes = isEqual
    (attrs2Lua tableWithCustomTypes)
    "a.a({a = some code, b = {1, 2}, c = {a = {a = someVar}}})\n";

  attrs2LuaEmpty = isEqual (attrs2Lua { }) "";

  # =====================================================
  # 2. LUA SYNTAX VALIDATION — Generated lua is parseable
  # =====================================================

  luaSyntaxMinimal      = luaSyntaxCheck "minimal"      (evalLua { });
  luaSyntaxSettings     = luaSyntaxCheck "settings"     (evalLua {
    set.termguicolors = true;
    set.number = true;
    set.tabstop = 4;
    vim.g.mapleader = " ";
  });
  luaSyntaxMappings     = luaSyntaxCheck "mappings"     (evalLua {
    nnoremap."<leader>w" = ":w<CR>";
    inoremap."<C-h>" = "<Left>";
  });
  luaSyntaxCustomLua    = luaSyntaxCheck "custom-lua"   (evalLua {
    lua = "print('hello from nix2vim')";
    lua' = "vim.cmd('colorscheme habamax')";
  });
  luaSyntaxVimscript    = luaSyntaxCheck "vimscript"    (evalLua {
    vimscript = "set number";
    vimscript' = "set wrap";
  });
  luaSyntaxSetup        = luaSyntaxCheck "setup"        (evalLua {
    setup.which-key = { };
  });
  luaSyntaxFunctions    = luaSyntaxCheck "functions"    (evalLua {
    function.myFunc = "print('hello')";
    function.another = "vim.cmd('echo hi')";
  });
  luaSyntaxFull         = luaSyntaxCheck "full"         (evalLua {
    set.termguicolors = true;
    set.number = true;
    set.tabstop = 4;
    nnoremap."<leader>w" = ":w<CR>";
    vimscript = "set mouse=a";
    lua = "print('hello')";
    setup.which-key = { };
    function.hello = "print('world')";
  });

  # =====================================================
  # 3. MODULE SMOKE TESTS — Each module produces valid lua
  # =====================================================

  luaSyntaxModuleEssentials  = luaSyntaxCheck "module-essentials"  (evalLua {
    imports = [ ../modules/essentials.nix ];
  });
  luaSyntaxModuleGit         = luaSyntaxCheck "module-git"         (evalLua {
    imports = [ ../modules/git.nix ];
  });
  luaSyntaxModuleNvimTree    = luaSyntaxCheck "module-nvim-tree"   (evalLua {
    imports = [ ../modules/nvim-tree.nix ];
  });
  luaSyntaxModuleTelescope   = luaSyntaxCheck "module-telescope"   (evalLua {
    imports = [ ../modules/telescope.nix ];
  });
  luaSyntaxModuleWhichKey    = luaSyntaxCheck "module-which-key"   (evalLua {
    imports = [ ../modules/which-key.nix ];
  });
  luaSyntaxModuleTreesitter  = luaSyntaxCheck "module-treesitter"  (evalLua {
    imports = [ ../modules/treesitter.nix ];
    treesitter.enable = true;
  });
  luaSyntaxModuleLsp         = luaSyntaxCheck "module-lsp"         (evalLua {
    imports = [ ../modules/lsp.nix ];
    lspconfig.enable = true;
  });
  luaSyntaxModuleNvchad      = luaSyntaxCheck "module-nvchad"      (evalLua {
    imports = [ ../modules/nvchad.nix ];
  });
  luaSyntaxModuleRust        = luaSyntaxCheck "module-rust"        (evalLua {
    imports = [ ../modules/rust.nix ];
  });
  luaSyntaxModuleAi          = luaSyntaxCheck "module-ai"          (evalLua {
    imports = [ ../modules/ai.nix ];
  });

  # Combined module stack (non-conflicting modules)
  luaSyntaxModuleCombined     = luaSyntaxCheck "modules-combined"  (evalLua {
    imports = [
      ../modules/essentials.nix
      ../modules/git.nix
      ../modules/nvim-tree.nix
      ../modules/telescope.nix
      ../modules/which-key.nix
      ../modules/nvchad.nix
    ];
  });

}
