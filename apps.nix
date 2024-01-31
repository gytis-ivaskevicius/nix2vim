{ utils, pkgs, lib ? pkgs.lib }:
let
  generateMarkdown = optionsFile:
    let
      dsl = import ./lib/dsl.nix { inherit lib; };
      options = (pkgs.lib.evalModules {
        modules = [ optionsFile ];

        specialArgs = { inherit pkgs dsl; };
      }).options;
      json = builtins.removeAttrs (pkgs.nixosOptionsDoc { inherit options; }).optionsNix [ "_module.args" ];
      parseDefinition = it: if builtins.isString it then it else if it._type == "literalExpression" then it.text else throw "Unknown definition: ${it}";
    in
    pkgs.writeText "options.md" (lib.concatStringsSep "\n\n" (lib.mapAttrsToList
      (name: value: ''
        ## ${name}

        ${value.description}

        **Type:** ${value.type}

        **Default:** `${parseDefinition (value.default or "")}`

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
  '');
}
