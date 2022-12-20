{
  description = "Kick ass neovim distrubution";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;

    nix2vim.url = github:gytis-ivaskevicius/nix2vim/blueprints;
    nix2vim.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { self, nixpkgs, nix2vim }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      neovimBuilder = pkgs.callPackage nix2vim.blueprints.neovimBuilder { };
      nix2vimDemo = pkgs.callPackage nix2vim.blueprints.nix2vimDemo { inherit neovimBuilder; };
    in
    {

      inherit nix2vimDemo;
      packages.${system} = {
        inherit nix2vimDemo;

        default = neovimBuilder {
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
      };
    };
}
