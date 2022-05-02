{ pkgs, ... }: {

  setup.lualine = {
    options = {
      component_separators = { left = ""; right = ""; };
      section_separators = { left = ""; right = ""; };
      globalstatus = true;
    };
    sections = {
      lualine_a = [ "mode" ];
      lualine_b = [ "branch" "diff" "diagnostics" ];
      lualine_c = [ "filename" ];
      lualine_x = [ "encoding" "fileformat" ];
      lualine_z = [ "location" ];
    };
    tabline = { };
    extensions = { };
  };

}
