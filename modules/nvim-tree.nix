{ pkgs, ... }: {

  plugins = with pkgs.vimPlugins; [ nvim-tree-lua ];

  setup.nvim-tree = {
    disable_netrw = true;
    hijack_netrw = true;
    open_on_setup = false;
    ignore_ft_on_setup = { };
    open_on_tab = false;
    hijack_cursor = false;
    update_cwd = false;
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
      update_cwd = false;
      ignore_list = { };
    };
    system_open = {
      cmd = null;
      args = { };
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
      hide_root_folder = false;
      side = "left";
      mappings = {
        custom_only = false;
        list = { };
      };
    };
  };
}
