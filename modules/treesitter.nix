{ lib, pkgs, ... }:

let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitter.dependencies;
  };
in
{
  plugins = with pkgs.vimPlugins; [
    treesitter
    nvim-treesitter-context
    nvim-ts-autotag
    nvim-ts-context-commentstring
    rainbow-delimiters-nvim
    vim-matchup
  ];

  setup.treesitter-context = {
    max_lines = 4;
    min_window_height = 30;
    multiline_threshold = 1;
    mode = "topline";
  };

  setup."nvim-treesitter.configs" = {
    highlight = {
      enable = true;
      use_languagetree = true;
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

  lua = ''
    vim.opt.runtimepath:append("${treesitter}")
    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';
}
