{ lib, config, ... }:

let
  inherit (lib) replaceStrings mkOption types literalExample flatten mapAttrsToList mapAttrs filterAttrs concatStringsSep filter attrValues;
  mkMappingOption = description: example: mkOption {
    inherit description example;
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
      type = types.anything;
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

    function = mkOption {
      example = literalExample ''
        {
          # Gets parsed to:
          # function abc()
          #   print 'hello world'
          # end
          abc = "print 'hello world'";
        }
      '';
      default = { };
      description = "Attribute set representing <function-name> -> <function-body> pairs";
      type = with types; attrsOf str;
    };

    use = mkOption {
      description = ''Allows requiring modules. Gets parset to "require('<name>').<attrs>"'';
      type = with types; attrsOf attrs;
      example = literalExample ''
        use.which-key.register = dsl.callWith {
          q = cmd "bdelete" "Delete buffer";
        }
      '';
      default = { };
    };

    setup = mkOption {
      description = ''Results in 'require(<name>).setup(<attrs>)'.'';
      type = with types; attrsOf attrs;
      example = literalExample ''
        setup.lsp_signature = {
          bind = true;
          hint_enable = false;
          hi_parameter = "Visual";
          handler_opts.border = "single";
        };
      '';
      default = { };
    };

    lua = mkOption {
      type = types.lines;
      default = "";
      description = "Lua config";
      example = ''
        local hooks = require "ibl.hooks"
        hooks.register(
          hooks.type.WHITESPACE,
          hooks.builtin.hide_first_space_indent_level
        )
      '';
    };

    lua' = mkOption {
      type = types.lines;
      default = "";
      description = "Lua config which is placed after `lua` script. Unfortunatelly sometimes config requires certain ordering";
      example = ''
        local hooks = require "ibl.hooks"
        hooks.register(
          hooks.type.WHITESPACE,
          hooks.builtin.hide_first_space_indent_level
        )
      '';
    };

    vimscript = mkOption {
      type = types.lines;
      default = "";
      example = "set number";
      description = "Vimscript config";
    };

    vimscript' = mkOption {
      type = types.lines;
      default = "";
      example = "set number";
      description = "Vimscript config which is placed after `lua` script. Unfortunatelly sometimes config requires certain ordering";
    };

    ############################################
    # Mappings                               ###
    ############################################
    nnoremap = mkMappingOption "Defines 'Normal mode' mappings" {
      "<leader>/" = ":nohl<cr>";
    };
    inoremap = mkMappingOption "Defines 'Insert and Replace mode' mappings" {
      "<C-h>" = "<Left>";
      "<C-j>" = "<Down>";
      "<C-k>" = "<Up>";
      "<C-l>" = "<Right>";
      "<C-BS>" = "<C-W>";
    };
    vnoremap = mkMappingOption "Defines 'Visual and Select mode' mappings" {
      "<" = "<gv";
      ">" = ">gv";
    };
    xnoremap = mkMappingOption "Defines 'Visual mode' mappings" {
      "<" = "<gv";
      ">" = ">gv";
    };
    snoremap = mkMappingOption "Defines 'Select mode' mappings" {
      "<CR>" = "a<BS>";
    };
    cnoremap = mkMappingOption "Defines 'Command-line mode' mappings" { RH = "Gitsigns reset_hunk"; };
    onoremap = mkMappingOption "Defines 'Operator pending mode' mappings" {
      imma-be-real-with-ya = "I have no idea what for one may use this";
    };
    tnoremap = mkMappingOption "Defines 'Terminal mode' mappings" {
      "<Esc>" = "<C-\><C-n>";
    };

    nmap = mkMappingOption "Defines 'Normal mode' mappings" {
      "<leader>/" = ":nohl<cr>";
    };
    imap = mkMappingOption "Defines 'Insert and Replace mode' mappings" {
      "<C-h>" = "<Left>";
      "<C-j>" = "<Down>";
      "<C-k>" = "<Up>";
      "<C-l>" = "<Right>";
      "<C-BS>" = "<C-W>";
    };
    vmap = mkMappingOption "Defines 'Visual and Select mode' mappings" {
      "<" = "<gv";
      ">" = ">gv";
    };
    xmap = mkMappingOption "Defines 'Visual mode' mappings" {
      "<" = "<gv";
      ">" = ">gv";
    };
    smap = mkMappingOption "Defines 'Select mode' mappings" {
      "<CR>" = "a<BS>";
    };
    cmap = mkMappingOption "Defines 'Command-line mode' mappings" { RH = "Gitsigns reset_hunk"; };
    omap = mkMappingOption "Defines 'Operator pending mode' mappings" {
      imma-be-real-with-ya = "I have no idea what for one may use this";
    };
    tmap = mkMappingOption "Defines 'Terminal mode' mappings" {
      "<Esc>" = "<C-\><C-n>";
    };
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

      requireBuilder = name: name_inner: value_inner:
        let
          varName = replaceStrings [ "-" "." ] [ "_" "_" ] name;
        in
        ''
          local ${varName} = require('${name}')
          ${varName}.${dsl.attrs2Lua {${name_inner} = value_inner; }}
        '';

      functions = mapAttrsToList
        (name: value: ''
          function ${name}()
            ${value}
          end
        '')
        config.function;
      require = flatten (mapAttrsToList (name: value: mapAttrsToList (requireBuilder name) value) config.use);
    in
    {
      vim.opt = config.set;
      use = mapAttrs (_: it: { setup = dsl.callWith it; }) config.setup;

      lua = ''
        ${toString functions}

        local _cmp_nvim_lsp_present, _cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local capabilities = nil
        if present then
            capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
        end

        ${dsl.attrs2Lua { inherit (config) vim; }}
        ${toString require}
        local map = vim.api.nvim_set_keymap
        ${noremaps}
        ${remaps}
        ${config.lua'}
      '';
    };
}
