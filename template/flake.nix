{
  description = "Kick ass neovim distrubution";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;

    skooter.url = github:gytis-ivaskevicius/skooter;
    skooter.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { self, nixpkgs, skooter, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ skooter.overlay ];
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
