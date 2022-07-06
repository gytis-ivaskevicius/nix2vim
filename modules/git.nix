{ pkgs, ... }: {

  plugins = with pkgs.vimPlugins; [
    diffview-nvim
    gitsigns-nvim
    neogit
    plenary-nvim
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
