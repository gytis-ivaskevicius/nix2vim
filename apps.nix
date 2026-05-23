{
  utils,
  pkgs,
  lib ? pkgs.lib,
}:
let
  optsDoc = import ./lib/generate-options-doc.nix { inherit pkgs lib; };
  inherit (optsDoc) generateMarkdown generatedRefs;

  mkApp = drv: utils.mkApp { inherit drv; };

  projectRoot = builtins.dirOf ./apps.nix;

  # Copy generated option reference files into the mdbook source
  populateRef = pkgs.writeShellScriptBin "populate-ref.sh" ''
    mkdir -p docs/src/reference
    cp -f ${generatedRefs."api.options.md"} docs/src/reference/api.options.md
    cp -f ${generatedRefs."wrapper.options.md"} docs/src/reference/wrapper.options.md
    cp -f ${generatedRefs."lsp.options.md"} docs/src/reference/lsp.options.md
    cp -f ${generatedRefs."treesitter.options.md"} docs/src/reference/treesitter.options.md
  '';

in
{
  generateDocs = mkApp (
    pkgs.writeShellScriptBin "create-docs.sh" ''
      set -e
      cd "${projectRoot}"
      echo "Generating option reference docs..."
      mkdir -p docs
      cp -f ${generatedRefs."api.options.md"} docs/api.options.md
      cp -f ${generatedRefs."wrapper.options.md"} docs/wrapper.options.md
      cp -f ${generatedRefs."lsp.options.md"} docs/lsp.options.md
      cp -f ${generatedRefs."treesitter.options.md"} docs/treesitter.options.md
      ${populateRef}/bin/populate-ref.sh
      echo "Done!"
    ''
  );

  buildMdBook = mkApp (
    pkgs.writeShellScriptBin "build-mdbook.sh" ''
      set -e
      cd "${projectRoot}"
      echo "Populating generated reference docs..."
      ${populateRef}/bin/populate-ref.sh
      echo "Building mdBook..."
      ${pkgs.mdbook}/bin/mdbook build docs
      echo "mdBook built successfully! Open ./book/index.html in your browser."
    ''
  );

  serveMdBook = mkApp (
    pkgs.writeShellScriptBin "serve-mdbook.sh" ''
      set -e
      cd "${projectRoot}"
      echo "Populating generated reference docs..."
      ${populateRef}/bin/populate-ref.sh
      echo "Starting mdBook server on http://localhost:3000..."
      ${pkgs.mdbook}/bin/mdbook serve docs --open
    ''
  );
}
