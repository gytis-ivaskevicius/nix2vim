{ lib, pkgs, ... }: {

  plugins = with pkgs.vimPlugins; [
    (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.passthru.allGrammars))
    nvim-treesitter-context
    nvim-ts-autotag
    nvim-ts-context-commentstring
    nvim-ts-rainbow
    vim-matchup
  ];

  setup.treesitter-context.setup = { };

  setup."nvim-treesitter.configs" = {
    #ensure_installed = "all";
    #ignore_install = [ ];

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
