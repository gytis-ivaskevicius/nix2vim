{ pkgs
, ...
}:
{
  plugins = with pkgs.vimPlugins; [
    windsurf-nvim
  ];

  setup.codeium = {
    language_server = "${pkgs.codeium}/bin/codeium_language_server";
  };
}
