# Configuration

nix2vim uses Nix's module system. All options are declared with types, defaults, and descriptions.

## API Options

Mirror Neovim's Lua API as Nix attributes. They get translated to Lua during build.

### `vim` / `set`

```nix
{ set.termguicolors = true; set.clipboard = "unnamed,unnamedplus"; }
```

### Mappings

Mode-specific options: `nmap`/`nnoremap`, `imap`/`inoremap`, `vmap`/`vnoremap`, `xmap`/`xnoremap`, `smap`/`snoremap`, `cmap`/`cnoremap`, `omap`/`onoremap`, `tmap`/`tnoremap`.

```nix
{ nnoremap."<leader>/" = ":nohl<cr>"; }
```

### `function`, `lua`, `vimscript`

```nix
{
  function.hello = "print 'hello'";
  lua = "local x = 1";
  vimscript = "set number";
}
```

### `setup`

Shorthand for `require('<name>').setup(<attrs>)`.

```nix
{ setup.lsp_signature = { bind = true; hint_enable = false; }; }
```

### `use`

Require modules with setup config.

```nix
{ use.which-key.register = dsl.callWith { q = "<cmd>bdelete<cr>"; }; }
```

## Wrapper Options

Control how the Neovim derivation is built.

| Option | Description |
|--------|-------------|
| `package` | Neovim package to use (`pkgs.neovim-unwrapped`) |
| `plugins` | Autoloaded plugins |
| `packages.<name>.start` / `.opt` | Fine-grained plugin loading |
| `extraLuaPackages` | Extra Lua packages (`it: [ it.cjson ]`) |
| `extraPython3Packages` | Extra Python packages |
| `enableViAlias` / `enableVimAlias` | Enable `vi`/`vim` aliases |
| `withNodeJs` / `withPython3` / `withRuby` | Enable runtime support |
| `extraMakeWrapperArgs` | Extra args for `makeWrapper` |
| `drvSuffix` | Suffix for the derivation name |

## LSP Options

```nix
{
  lspconfig.enable = true;
  lspconfig.lsp.tsserver = {
    cmd = [ (lib.getExe pkgs.nodePackages.typescript-language-server) "--stdio" ];
    filetypes = [ "typescript" "typescriptreact" ];
  };
}
```

## Treesitter Options

```nix
{
  treesitter.enable = true;
  treesitter.options.highlight.enable = true;
  treesitter.package = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
}
```

For the full reference with all types, defaults, and examples, see the [auto-generated options reference](./reference/index.md).
