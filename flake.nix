{
  description = "Next generation neovim configuration framework";

  outputs = { self }:
    let
      dsl = import ./lib/dsl.nix;
      optionsApi = ./lib/api.options.nix;
      optionsWrapper = ./lib/wrapper.options.nix;

      nix2luaUtils = import ./lib/utils.nix;

      neovimBuilder = import ./lib/neovim-builder.nix;

      nix2vimDemo = { neovimBuilder }: neovimBuilder {
        imports = builtins.attrValues self.modules.nix2vim;
        enableViAlias = true;
        enableVimAlias = true;
      };

    in
    {
      lib = { inherit dsl optionsApi optionsWrapper; };
      blueprints = { inherit nix2luaUtils neovimBuilder nix2vimDemo; };

      modules.nix2vim = {
        essentials = ./modules/essentials.nix;
        git = ./modules/git.nix;
        lsp = ./modules/lsp.nix;
        nvim-tree = ./modules/nvim-tree.nix;
        styling = ./modules/styling.nix;
        treesitter = ./modules/treesitter.nix;
        telescope = ./modules/telescope.nix;
        which-key = ./modules/which-key.nix;
      };

      templates.default = {
        path = ./template;
        description = "A very basic neovim configuration";
      };
    };
}
