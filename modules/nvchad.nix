{ pkgs, dsl, ... }:
let
  inherit (dsl) callWith;
  nvchad-ui-config = pkgs.runCommand "nvchad-utils" { } ''
    mkdir -p $out/lua/core
    cp ${./nvconfig.lua} $out/lua/nvconfig.lua
  '';
in
{
  plugins = with pkgs.vimPlugins; [
    base46
    indent-blankline-nvim
    nvchad-ui
    nvim-colorizer-lua
    nvim-web-devicons
    plenary-nvim
    nvchad-ui-config
  ];

  vim.g = {
    toggle_theme_icon = "   ";
    nvchad_theme = "onedark";
    transparency = false;
  };

  use.base46.load_all_highlights = callWith null;

  setup.ibl = {
    indent.highlight = "IndentBlanklineChar";
    indent.char = "│";
    scope = {
      show_end = true;
      show_exact_scope = true;
    };
  };

  vimscript = ''
    highlight IndentBlanklineChar guifg=#31353d
  '';

  lua = ''
    vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"

    local hooks = require "ibl.hooks"
    hooks.register(
      hooks.type.WHITESPACE,
      hooks.builtin.hide_first_space_indent_level
    )
  '';
}

