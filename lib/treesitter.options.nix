{ lib, pkgs, dsl, config, ... }:

let
  inherit (lib) mkIf types mkOption mkEnableOption mdDoc literalExpression;
  cfg = config.treesitter;
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = cfg.package.dependencies;
  };
in
{

  options.treesitter = {
    enable = mkEnableOption (mdDoc "Treesitter");

    package = mkOption {
      type = types.package;
      default = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
      defaultText = literalExpression "pkgs.vimPlugins.nvim-treesitter.withAllGrammars";
      description = lib.mdDoc "nvim-treesitter plugin to use. May be configured with different grammars";
    };

    options = mkOption {
      type = types.anything;
      default = { };
      description = lib.mdDoc "nvim-treesitter setup options";
      example = literalExpression ''
        {
          highlight = {
            enable = true;
            use_languagetree = true;
          };
        }
      '';
    };
  };


  config = mkIf cfg.enable {
    plugins = [ cfg.package ];

    setup."nvim-treesitter.configs" = cfg.options;

    lua = ''
      vim.opt.runtimepath:append("${cfg.package}")
      vim.opt.runtimepath:append("${treesitter-parsers}")
    '';
  };

}
