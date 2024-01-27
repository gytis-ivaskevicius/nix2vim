{ lib, pkgs, config, ... }:

let
  cfg = config;
  inherit (lib) types mkEnableOption mkOption literalExpression;
in
{
  options = {
    withNodeJs = mkEnableOption "Node.js";
    withRuby = mkEnableOption "Ruby";
    withPython3 = mkEnableOption "Python 3";

    enableViAlias = mkEnableOption "'vi' alias";
    enableVimAlias = mkEnableOption "'vim' alias";

    extraMakeWrapperArgs = mkOption {
      type = types.str;
      default = "";
      description = "Should contain all args but the binary. https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh";
      example = "--set ABC 123";
    };

    drvSuffix = mkOption {
      description = "Suffix of generated neovim derivation";
      type = types.str;
      default = "-nix2vim";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.neovim-unwrapped;
      example = literalExpression "pkgs.neovim-unwrapped";
      description = "Neovim package to use.";
    };

    drv = mkOption {
      type = types.package;
      description = "This option contains the store path that represents neovim.";
      readOnly = true;
    };

    extraPython3Packages = mkOption {
      type = types.functionTo (types.listOf types.package);
      default = _: [ ];
      description = "The function you would have passed to python.withPackages";
      example = literalExpression ''
        it: [ it.requests ]
      '';
    };

    extraLuaPackages = mkOption {
      type = types.functionTo (types.listOf types.package);
      default = _: [ ];
      description = "The function you would have passed to lua.withPackages";
      example = literalExpression ''
        it: [ it.cjson ]
      '';
    };

    plugins = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Plugins to be autoloaded";
      example = literalExpression ''
        with pkgs.vimPlugins; [ dracula-vim ]
      '';
    };

    optionalPlugins = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Optional plugins";
      example = literalExpression ''
        with pkgs.vimPlugins; [ dracula-vim ]
      '';
    };

    packages = mkOption {
      type = types.attrsOf (types.submodule ({
        options.start = mkOption {
          type = types.listOf types.package;
          default = [ ];
          description = "Plugins to be autoloaded";
          example = literalExpression ''
            with pkgs.vimPlugins; [ dracula-vim ]
          '';
        };

        options.opt = mkOption {
          type = types.listOf types.package;
          default = [ ];
          description = "Optional plugins";
          example = literalExpression ''
            with pkgs.vimPlugins; [ dracula-vim ]
          '';
        };
      }));
      default = { };
      description = "Attributes gets passed to 'configure.packages'";
      example = literalExpression ''
        with pkgs.vimPlugins; {
          start = [ ];
          opt = [];
        };
      '';
    };

  };


  config = {
    packages.nix2vim = { start = config.plugins; opt = config.optionalPlugins; };

    drv = pkgs.wrapNeovim cfg.package {
      inherit (cfg) withNodeJs withPython3 withRuby extraMakeWrapperArgs extraPython3Packages extraLuaPackages;
      viAlias = cfg.enableViAlias;
      vimAlias = cfg.enableVimAlias;


      configure = {
        #plugins = []; # expects { plugin=far-vim; config = "let g:far#source='rg'"; optional = false; }
        inherit (cfg) packages;
        customRC = ''
          ${cfg.vimscript}

          luafile ${pkgs.writeText "nix2vim.lua" cfg.lua}
          ${cfg.vimscript'}
        '';
      };
    };


  };

}
