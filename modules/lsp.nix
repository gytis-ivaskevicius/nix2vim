{ pkgs, dsl, ... }: with dsl; {

  plugins = with pkgs.vimPlugins; [
    cmp-buffer
    cmp-nvim-lsp
    lsp_signature-nvim
    lspkind-nvim
    nvim-cmp
    nvim-lspconfig
  ];

  setup.lsp_signature = {
    bind = true;
    hint_enable = false;
    hi_parameter = "Visual";
    handler_opts.border = "single";
  };

  setup.cmp = {
    mapping = {
      "['<C-n>']" = rawLua "require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<C-p>']" = rawLua "require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Insert })";
      "['<Down>']" = rawLua "require('cmp').mapping.select_next_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<Up>']" = rawLua "require('cmp').mapping.select_prev_item({ behavior = require('cmp').SelectBehavior.Select })";
      "['<C-d>']" = rawLua "require('cmp').mapping.scroll_docs(-4)";
      "['<C-f>']" = rawLua "require('cmp').mapping.scroll_docs(4)";
      "['<C-Space>']" = rawLua "require('cmp').mapping.complete()";
      "['<C-e>']" = rawLua "require('cmp').mapping.close()";
      "['<CR>']" = rawLua "require('cmp').mapping.confirm({ behavior = require('cmp').ConfirmBehavior.Replace, select = true, })";
    };
    sources = [
      { name = "nvim_lsp"; }
      { name = "buffer"; }
    ];
  };

  use.lspconfig.rnix.setup = callWith {
    cmd = [ "${pkgs.rnix-lsp}/bin/rnix-lsp" ];
    capabilities = rawLua "require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())";
  };

  use.lspconfig.rust_analyzer.setup = callWith {
    cmd = [ "${pkgs.rust-analyzer}/bin/rust-analyzer" ];
    capabilities = rawLua "require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())";
  };

  use.lspconfig.solargraph.setup = callWith {
    cmd = [ "${pkgs.solargraph}/bin/solargraph" "stdio" ];
    capabilities = rawLua "require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())";
  };


}
