{ lib, config, ... }:

with lib; {
  options = {

    vim = mkOption {
      default = { };
      example = {
        vim.opt.termguicolors = true;
        vim.opt.clipboard = "unnamed,unnamedplus";
      };
      description = "Represents 'vim' namespace from neovim lua api.";
      type = types.attrs;
    };

    set = mkOption {
      example = {
        set.termguicolors = true;
        set.clipboard = "unnamed,unnamedplus";
      };
      description = "'vim.opt' alias. Acts same as vimscript 'set' command";
      type = with types; attrsOf (oneOf [ bool float int str ]);
    };

  };

  config = {
    vim.opt = config.set;
  };
}
