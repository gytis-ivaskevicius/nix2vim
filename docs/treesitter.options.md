## treesitter.enable

Whether to enable Treesitter.


**Type:** boolean

**Default:** `false`

**Example:**
```nix
true
```


## treesitter.options

nvim-treesitter setup options


**Type:** anything

**Default:** `{ }`

**Example:**
```nix
{
  highlight = {
    enable = true;
    use_languagetree = true;
  };
}

```


## treesitter.package

nvim-treesitter plugin to use. May be configured with different grammars


**Type:** package

**Default:** `pkgs.vimPlugins.nvim-treesitter.withAllGrammars`

**Example:**
```nix
(pkgs.vimPlugins.nvim-treesitter.withPlugins (grammars: with grammars; [
  tree-sitter-bash
  tree-sitter-c
  tree-sitter-fish
  tree-sitter-hcl
  tree-sitter-ini
  tree-sitter-json
  tree-sitter-lua
  tree-sitter-markdown
  tree-sitter-markdown-inline
  tree-sitter-nix
  tree-sitter-puppet
  tree-sitter-python
  tree-sitter-rasi
  tree-sitter-toml
  tree-sitter-vimdoc
  tree-sitter-yaml
]))

```
