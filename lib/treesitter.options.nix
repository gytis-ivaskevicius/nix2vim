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
      example = literalExpression ''
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (grammars: with grammars; [
          tree-sitter-bash
          tree-sitter-c
          tree-sitter-fish
          tree-sitter-hcl
          tree-sitter-ini
          tree-sitter-json
          tree-sitter-lua
          tree-sitter-markdown
          tree-sitter-markdown-inline
          tree-sitter-nix
          tree-sitter-puppet
          tree-sitter-python
          tree-sitter-rasi
          tree-sitter-toml
          tree-sitter-vimdoc
          tree-sitter-yaml
        ]))
      '';
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
