{ lib, pkgs, dsl, ... }:

{
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter-context
    nvim-ts-autotag
    nvim-ts-context-commentstring
    comment-nvim
    rainbow-delimiters-nvim
    vim-matchup
  ];


  setup.treesitter-context = {
    max_lines = 4;
    min_window_height = 30;
    multiline_threshold = 1;
    mode = "topline";
  };

  setup.Comment = {
    toggler.line = "<C-_>";
    opleader.line = "<C-_>";
    mappings.extra = false;
    pre_hook = dsl.rawLua "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
  };

  treesitter.enable = true;
  treesitter.options = {
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
    autotag.enable = true;
  };

  lua' = ''
    vim.cmd[[highlight clear MatchWord]]
    vim.cmd[[highlight MatchWord cterm=italic,underline gui=italic,underline]]
  '';
}
