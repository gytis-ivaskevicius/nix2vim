{ pkgs, ... }: {

  plugins = with pkgs.vimPlugins; [
    diffview-nvim
    gitsigns-nvim
    neogit
    plenary-nvim
  ];

  setup.gitsigns = { };

  nmap."gs" = ":Gitsigns preview_hunk<CR>";
  nmap."gb" = ":Gitsigns blame_line<CR>";
  nmap."gc" = ":Gitsigns next_hunk<CR>";
  nmap."]j" = ":Gitsigns next_hunk<CR>";
  nmap."[k" = ":Gitsigns prev_hunk<CR>";

  setup.neogit = {
    signs = {
      section = [ "" "" ];
      item = [ "" "" ];
    };

    integrations.diffview = true;
  };

}
