{ pkgs, ... }: {

  plugins = with pkgs.vimPlugins; [
    diffview-nvim
    gitsigns-nvim
    neogit
  ];

  setup.gitsigns = { };

  setup.neogit = {
    signs = {
      section = [ "" "" ];
      item = [ "" "" ];
    };

    integrations.diffview = true;
  };

}
