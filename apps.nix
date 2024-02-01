{ utils, pkgs, lib ? pkgs.lib }:
let
  generateMarkdown = optionsFile:
    let
      dsl = import ./lib/dsl.nix { inherit lib; };
      options = (pkgs.lib.evalModules {
        modules = [
          ./lib/wrapper.options.nix
          ./lib/api.options.nix
          ./lib/lsp.options.nix
          ./lib/treesitter.options.nix
        ];

        specialArgs = { inherit pkgs dsl; };
      }).options;
      json = lib.filterAttrs (_: v: builtins.elem (toString optionsFile) v.declarations) (pkgs.nixosOptionsDoc { inherit options; }).optionsNix;
      parseDefinition = it: if builtins.isString it then it else if it._type == "literalExpression" then it.text else throw "Unknown definition: ${it}";
    in
    pkgs.writeText "options.md" (lib.concatStringsSep "\n\n" (lib.mapAttrsToList
      (name: value: ''
        ## ${builtins.replaceStrings ["<" ">"] [ "\\<" "\\>"] name}

        ${value.description}


        **Type:** ${value.type}

        **Default:** `${value.defaultText or parseDefinition (value.default or "")}`

        **Example:**
        ```nix
        ${parseDefinition (value.example or "")}
        ```
      '')
      json));
  mkApp = drv: utils.mkApp { inherit drv; };
in
{
  generateDocs = mkApp (pkgs.writeShellScriptBin "create-docs.sh" ''
    mkdir -p docs
    cp -f ${generateMarkdown ./lib/api.options.nix} docs/api.options.md
    cp -f ${generateMarkdown ./lib/wrapper.options.nix} docs/wrapper.options.md
    cp -f ${generateMarkdown ./lib/lsp.options.nix} docs/lsp.options.md
    cp -f ${generateMarkdown ./lib/treesitter.options.nix} docs/treesitter.options.md
  '');
}
