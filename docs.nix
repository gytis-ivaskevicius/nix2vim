{ pkgs, lib }:

let
  inherit (lib) concatStringsSep mapAttrsToList;

  optsDoc = import ./lib/generate-options-doc.nix { inherit pkgs lib; };

  # Create a copy of the docs source with real reference content injected
  preparedSrc = pkgs.runCommand "nix2vim-mdbook-src" { } ''
    cp -r ${./docs}/. $out
    chmod -R u+w $out
    ${concatStringsSep "\n" (
      mapAttrsToList (name: drv: ''
        cp ${drv} $out/src/reference/${name}
      '') optsDoc.generatedRefs
    )}
  '';
in
{
  # Build the mdBook as a derivation (produces HTML output)
  mdbookDocs = pkgs.stdenv.mkDerivation {
    name = "nix2vim-mdbook";
    src = preparedSrc;
    buildInputs = [ pkgs.mdbook ];
    buildPhase = ''
      mdbook build . --dest-dir $out
    '';
    dontInstall = true;
  };
}
