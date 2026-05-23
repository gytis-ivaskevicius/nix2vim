# nix2vim DSL

The DSL (`lib/dsl.nix`) provides helpers for advanced Lua generation.

| Function | Description |
|----------|-------------|
| `dsl.callWith attrs` | Generates a function call `name(attrs)` |
| `dsl.rawLua content` | Inserts raw Lua, bypassing conversion |
| `dsl.toTable value` | Renders value as a Lua table, not JSON |
| `dsl.flatten attrs` | Flattens nested attrs to dot-separated keys |
| `dsl.attrs2Lua attrs` | Converts attrs to a Lua string |
| `dsl.nix2lua value` | Core Nix-to-Lua conversion function |

```nix
dsl.callWith { q = "<cmd>bdelete<cr>"; desc = "Delete buffer"; }
# => which-key.register({ q = "<cmd>bdelete<cr>", desc = "Delete buffer" })
```
