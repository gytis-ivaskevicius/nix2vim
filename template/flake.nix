{
  description = "Kick ass neovim distrubution";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;

    nix2vim.url = github:gytis-ivaskevicius/nix2vim;
    nix2vim.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { self, nixpkgs, nix2vim, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix2vim.overlay ];
        };
      in
      {

        packages.default = pkgs.neovimBuilder {
          imports = [
            ./someModule.nix
          ];
          enableViAlias = true;
          enableVimAlias = true;

          plugins = with pkgs.vimPlugins; [
            dracula-vim
          ];

          vimscript = ''
            colorscheme dracula
          '';

        };
      });
}
