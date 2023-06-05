{ lib, pkgs, ... }: {

  plugins = with pkgs.vimPlugins; [
    #(nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.passthru.allGrammars))
    (nvim-treesitter.withPlugins (plugins: with plugins;[
      tree-sitter-bash
      tree-sitter-css
      tree-sitter-dockerfile
      tree-sitter-html
      tree-sitter-javascript
      tree-sitter-json
      tree-sitter-lua
      tree-sitter-make
      tree-sitter-markdown
      tree-sitter-nix
      tree-sitter-python
      tree-sitter-ruby
      tree-sitter-rust
      tree-sitter-scss
      tree-sitter-terraform
      tree-sitter-toml
      tree-sitter-typescript
      tree-sitter-vim
      tree-sitter-yaml
    ]))
    nvim-treesitter
    nvim-treesitter-context
    nvim-ts-autotag
    nvim-ts-context-commentstring
    nvim-ts-rainbow
    vim-matchup
  ];

  setup.treesitter-context.setup = { };

  setup."nvim-treesitter.configs" = {
    #ensure_installed = "all";
    #ignore_install = [ "bash" ];

    parser_install_dir = "$HOME/.config/nvim/treesitter";

    highlight = {
      enable = true;
      use_languagetree = true;
      #disable = [ ];
    };

    incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = "<C-n>";
        node_incremental = "<C-n>";
        scope_incremental = "<C-s>";
        node_decremental = "<C-p>";
      };
    };
    indent.enable = true;

    rainbow = {
      enable = true;
      disable = [ ];
      extended_mode = true;
      max_file_lines = 10000;
      colors = [ "#bd93f9" "#6272a4" "#8be9fd" "#50fa7b" "#f1fa8c" "#ffb86c" "#ff5555" ];
    };
    textobjects = {
      select = {
        enable = true;
        lookahead = true;

        keymaps = {
          "['af']" = "@function.outer";
          "['if']" = "@function.inner";
          "['ac']" = "@class.outer";
          "['ic']" = "@class.inner";
        };
      };
    };
    matchup.enable = true;
    autotag.enable = true;
  };
}
