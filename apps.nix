{ utils, pkgs, lib ? pkgs.lib }:
let
  generateMarkdown = optionsFile:
    let
      dsl = import ./lib/dsl.nix { inherit lib; };
      options = (pkgs.lib.evalModules {
        modules = [ optionsFile ];

        specialArgs = { inherit pkgs dsl; };
      }).options;
    in
    (pkgs.nixosOptionsDoc { inherit options; }).optionsCommonMark;
in
{
  generateDocs = pkgs.writeShellScriptBin "create-docs.sh" ''
    mkdir docs
    cp -f ${generateMarkdown ./lib/api.options.nix} docs/api.options.md
    cp -f ${generateMarkdown ./lib/wrapper.options.nix} docs/wrapper.options.md
  '';
}
