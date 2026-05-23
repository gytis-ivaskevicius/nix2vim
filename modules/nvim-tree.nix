{ pkgs, ... }:
{

  plugins = with pkgs.vimPlugins; [ nvim-tree-lua ];

  setup.nvim-tree = {
    disable_netrw = true;
    hijack_netrw = true;
    hijack_cursor = false;
    diagnostics = {
      enable = false;
      icons = {
        hint = "";
        info = "";
        warning = "";
        error = "";
      };
    };
    update_focused_file = {
      enable = false;
      ignore_list = { };
    };
    filters = {
      dotfiles = false;
      custom = { };
    };
    git = {
      enable = true;
      ignore = true;
      timeout = 500;
    };
    view = {
      width = 30;
      side = "left";
    };
  };
}
