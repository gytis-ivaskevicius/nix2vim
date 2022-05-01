{ lib, config, ... }:

with lib;
let
  mkMappingOption = description: mkOption {
    inherit description;
    example = { abc = ":FZF<CR>"; C-p = ":FZF<CR>"; }; # Probably should be overwritten per option basis
    default = { };
    type = with types; attrsOf (nullOr str);
  };
in
{
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
      default = { };
      description = "'vim.opt' alias. Acts same as vimscript 'set' command";
      type = with types; attrsOf (oneOf [ bool float int str ]);
    };

    use = mkOption {
      description = ''Allows requiring modules. Gets parset to "require('<name>').<attrs>"'';
      type = with types; attrsOf attrs;
      default = { };
    };

    setup = mkOption {
      description = ''Results in 'require(<name>).setup(<attrs>)'.'';
      type = with types; attrsOf attrs;
      default = { };
    };

    lua = mkOption {
      type = types.lines;
      default = "";
      description = "Lua config";
    };

    vimscript = mkOption {
      type = types.lines;
      default = "";
      description = "Vimscript config";
    };

    nnoremap = mkMappingOption "Defines 'Normal mode' mappings";
    inoremap = mkMappingOption "Defines 'Insert and Replace mode' mappings";
    vnoremap = mkMappingOption "Defines 'Visual and Select mode' mappings";
    xnoremap = mkMappingOption "Defines 'Visual mode' mappings";
    snoremap = mkMappingOption "Defines 'Select mode' mappings";
    cnoremap = mkMappingOption "Defines 'Command-line mode' mappings";
    onoremap = mkMappingOption "Defines 'Operator pending mode' mappings";
    tnoremap = mkMappingOption "Defines 'Terminal mode' mappings";

    nmap = mkMappingOption "Defines 'Normal mode' mappings";
    imap = mkMappingOption "Defines 'Insert and Replace mode' mappings";
    vmap = mkMappingOption "Defines 'Visual and Select mode' mappings";
    xmap = mkMappingOption "Defines 'Visual mode' mappings";
    smap = mkMappingOption "Defines 'Select mode' mappings";
    cmap = mkMappingOption "Defines 'Command-line mode' mappings";
    omap = mkMappingOption "Defines 'Operator pending mode' mappings";
    tmap = mkMappingOption "Defines 'Terminal mode' mappings";
  };

  config =
    let
      trace = it: builtins.trace (builtins.toJSON it) it;
      dsl = import ./dsl.nix { inherit lib; };

      filterNonNull = mappings: filterAttrs (name: value: value != null) mappings;

      mapping = mode: lhs: rhs: { ... }@args: "map('${mode}', '${lhs}', '${rhs}', ${dsl.nix2lua args})\n";
      remap = mode: lhs: rhs: "map('${mode}', '${lhs}', '${rhs}', {})\n";
      noremap = mode: lhs: rhs: mapping mode lhs rhs { noremap = true; };

      attrsToStr = f: it: concatStringsSep "" (filter (it: it != [ ]) (attrValues (mapAttrs f it)));

      aggregateMappings = mapingFunction: { ... }@args: attrsToStr
        (mode: bindings:
          attrsToStr (lhs: rhs: mapingFunction mode lhs rhs) bindings
        )
        args;

      noremaps = aggregateMappings noremap {
        n = config.nnoremap;
        i = config.inoremap;
        v = config.vnoremap;
        x = config.xnoremap;
        s = config.snoremap;
        c = config.cnoremap;
        o = config.onoremap;
        t = config.tnoremap;
      };

      remaps = aggregateMappings remap {
        n = config.nmap;
        i = config.imap;
        v = config.vmap;
        x = config.xmap;
        s = config.smap;
        c = config.cmap;
        o = config.omap;
        t = config.tmap;
      };

      require = flatten (mapAttrsToList (name: value: mapAttrsToList (name_inner: value_inner: "require('${name}').${dsl.attrs2Lua {${name_inner} = value_inner; }}") value) config.use);
    in
    {
      vim.opt = config.set;
      use = mapAttrs (_: it: { setup = dsl.callWith it; }) config.setup;

      lua = ''
        ${dsl.attrs2Lua { inherit (config) vim; }}
        ${concatStringsSep "" require}
        local map = vim.api.nvim_set_keymap
        ${noremaps}
        ${remaps}
      '';
    };
}
