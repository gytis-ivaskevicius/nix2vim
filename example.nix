{ pkgs, dsl, ... }: with dsl; {

  nnoremap.C-s = ":w<CR>";
  inoremap.abc = ":w<CR>";
  vnoremap.xyz = ":w<CR>";

  nmap.C-s = ":w<CR>";
  imap.abc = ":w<CR>";
  vmap.xyz = ":w<CR>";

  set.number = true;

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


  vim.g = {
    mapleader = " ";
    nofoldenable = true;
    noshowmode = true;
    completeopt = "menu,menuone,noselect";
  };
  vim.o = {
    termguicolors = true;
    showcmd = true;
    showmatch = true;
    ignorecase = true;
    smartcase = true;
    cursorline = true;
    wrap = true;
    autoindent = true;
    copyindent = true;
    splitbelow = true;
    splitright = true;
    title = true;
    undofile = true;
    autoread = true;
    hidden = true;
    list = true;
    background = "dark";
    backspace = "indent,eol,start";
    undolevels = 1000000;
    undoreload = 1000000;
    foldmethod = "indent";
    foldnestmax = 10;
    foldlevel = 1;
    scrolloff = 3;
    sidescrolloff = 5;
    listchars = "tab:→→,trail:●,nbsp:○";
    clipboard = "unnamed,unnamedplus";
    formatoptions = "tcqj";
    encoding = "utf-8";
    fileencoding = "utf-8";
    fileencodings = "utf-8";
    bomb = true;
    binary = true;
    matchpairs = "(:),{:},[:],<:>";
    expandtab = true;
    wildmode = "list:longest,list:full";
  };
}
