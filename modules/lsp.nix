{ pkgs, lib, dsl, ... }: with dsl;
let
  inherit (lib) getExe;
  capabilities = rawLua "capabilities";
in
{

  imports = [
    ./rust.nix
  ];

  plugins = with pkgs.vimPlugins; [
    # completion framework
    cmp-nvim-lsp
    nvim-cmp
    cmp-buffer
    # lsp things
    lsp_signature-nvim
    lspkind-nvim
    nvim-lspconfig
    # utility functions for lsp
    plenary-nvim
    # popout for documentation
    popup-nvim
    # snippets lists
    friendly-snippets
    # for showing lsp progress
    fidget-nvim
  ];

  setup.fidget = { };

  setup.lsp_signature = {
    bind = true;
    hint_enable = false;
    hi_parameter = "Visual";
    handler_opts.border = "single";
  };

  setup.cmp = {
    mapping = {
      "['<C-n>']" = rawLua "cmp.mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<Down>']" = rawLua "cmp.mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<Tab>']" = rawLua "cmp.mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Select })";

      "['<C-p>']" = rawLua "cmp.mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<Up>']" = rawLua "cmp.mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<S-Tab>']" = rawLua "cmp.mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Select })";

      "['<C-d>']" = rawLua "cmp.mapping.scroll_docs(-4)";
      "['<C-f>']" = rawLua "cmp.mapping.scroll_docs(4)";
      "['<C-Space>']" = rawLua "cmp.mapping.complete()";
      "['<C-e>']" = rawLua "cmp.mapping.close()";
      "['<CR>']" = rawLua "cmp.mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true, })";
    };
    sources = [
      { name = "nvim_lsp"; }
      { name = "buffer"; }
      { name = "vsnip"; }
      { name = "crates"; }
      { name = "path"; }
    ];
    snippet.expand = rawLua ''function(args) vim.fn["vsnip#anonymous"](args.body) end '';
  };

  function.show_documentation = ''
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim','help' }, filetype) then
        vim.cmd('h '..vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({ 'man' }, filetype) then
        vim.cmd('Man '..vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' then
        require('crates').show_popup()
    else
        vim.lsp.buf.hover()
    end
  '';

  use.lspconfig.rnix.setup = callWith {
    cmd = [ (getExe pkgs.rnix-lsp) ];
    inherit capabilities;
  };

  use.lspconfig.jsonls.setup = callWith {
    cmd = [ (getExe pkgs.nodePackages.vscode-json-languageserver) "--stdio" ];
    inherit capabilities;
  };

  use.lspconfig.solargraph.setup = callWith {
    cmd = [ "${pkgs.solargraph}/bin/solargraph" "stdio" ];
    inherit capabilities;
  };

  use.lspconfig.clangd.setup = callWith {
    cmd = [ "${pkgs.clang-tools}/bin/clangd" ];
    inherit capabilities;
  };

  use.lspconfig.gopls.setup = callWith {
    cmd = [ "${pkgs.gopls}/bin/gopls" ];
    inherit capabilities;
  };

  use.lspconfig.pyright.setup = callWith {
    cmd = [ "${pkgs.pyright}/bin/pyright-langserver" "--stdio" ];
    inherit capabilities;
  };

  use.lspconfig.terraformls.setup = callWith {
    cmd = [ "${pkgs.terraform-ls}/bin/terraform-lsp" ];
    inherit capabilities;
  };


}
