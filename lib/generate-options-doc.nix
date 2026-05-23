{ pkgs, lib }:

let
  inherit (lib)
    concatStringsSep
    mapAttrsToList
    filterAttrs
    elem
    toString
    replaceStrings
    ;

  dsl = import ./dsl.nix { inherit lib; };

  # Evaluate all options modules to get the full set of options
  evaluated = pkgs.lib.evalModules {
    modules = [
      ./wrapper.options.nix
      ./api.options.nix
      ./lsp.options.nix
      ./treesitter.options.nix
    ];
    specialArgs = { inherit pkgs dsl; };
  };

  parseDefinition =
    it:
    if builtins.isString it then
      it
    else if it._type == "literalExpression" then
      it.text
    else
      throw "Unknown definition: ${it}";

  allOptionsNix = (pkgs.nixosOptionsDoc { options = evaluated.options; }).optionsNix;

  generateMarkdown =
    optionsFile:
    pkgs.writeText "options.md" (
      let
        json = filterAttrs (_: v: elem (toString optionsFile) v.declarations) allOptionsNix;
      in
      concatStringsSep "

" (
        mapAttrsToList (name: value: ''
          ## ${replaceStrings [ "<" ">" ] [ "\<" "\>" ] name}

          ${value.description}


          **Type:** ${value.type}

          **Default:** `${value.defaultText or parseDefinition (value.default or "")}`

          **Example:**
          ```nix
          ${parseDefinition (value.example or "")}
          ```
        '') json
      )
    );
in
{
  inherit generateMarkdown;

  # Convenience: all four reference markdown files
  generatedRefs = {
    "api.options.md" = generateMarkdown ./api.options.nix;
    "wrapper.options.md" = generateMarkdown ./wrapper.options.nix;
    "lsp.options.md" = generateMarkdown ./lsp.options.nix;
    "treesitter.options.md" = generateMarkdown ./treesitter.options.nix;
  };
}
