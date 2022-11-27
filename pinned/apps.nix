{ _lib, pkgs, lib ? pkgs.lib }:
let
  generateMarkdown = optionsFile:
    let
      options = (pkgs.lib.evalModules {
        modules = [ optionsFile ];
        specialArgs = {
          inherit pkgs;
          dsl = _lib.dsl;
        };
      }).options;
    in
    (pkgs.nixosOptionsDoc { inherit options; }).optionsCommonMark;

  mkApp = drv: {
    type = "app";
    program = "${drv}${drv.passthru.exePath or "/bin/${drv.pname or drv.name}"}";
  };
in
{
  generateDocs = mkApp (pkgs.writeShellScriptBin "create-docs.sh" ''
    cd $(${lib.getExe pkgs.git} rev-parse --show-toplevel)
    mkdir -p docs
    cp -f ${generateMarkdown _lib.optionsApi} docs/api.options.md
    cp -f ${generateMarkdown _lib.optionsWrapper} docs/wrapper.options.md
  '');
}
