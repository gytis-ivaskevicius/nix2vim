## lspconfig.capabilities

List of attribute set of capabilities which get mered using `vim.tbl_deep_extend` with behavior 'force'


**Type:** list of string

**Default:** `[
  "vim.lsp.protocol.make_client_capabilities()"
  "require('cmp_nvim_lsp').default_capabilities()"
  "{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }"
]`

**Example:**
```nix
[
  "vim.lsp.protocol.make_client_capabilities()"
  "require('cmp_nvim_lsp').default_capabilities()"
  # File watching is disabled by default for neovim.
  # See: https://github.com/neovim/neovim/pull/22405
  "{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }"
]

```


## lspconfig.enable

Whether to enable LspConfig.


**Type:** boolean

**Default:** `false`

**Example:**
```nix
true
```


## lspconfig.lsp

Configures defined Lsp's using lspconfig, attaches capabilities defined by `lspconfig.capabilities` and wraps `on_attach` argument if defined in a funchtion such as:

```lua
function(client, bufnr)
  ${on_attach}
end
```



**Type:** attribute set of (attribute set)

**Default:** ``

**Example:**
```nix
tsserver = {
  cmd = [ (lib.getExe pkgs.nodePackages.typescript-language-server) "--stdio" ];
  filetypes = [ "json" "javascript" "javascriptreact" "javascript.jsx" "typescript" "typescriptreact" "typescript.tsx" ];
  on_attach = ''
    print("Hello world from your LSP!!!")
  '';
};

```
