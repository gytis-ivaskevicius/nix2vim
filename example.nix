{ pkgs, dsl }: with dsl; {

  nnoremap.C-s = ":w<CR>";
  inoremap.abc = ":w<CR>";
  vnoremap.xyz = ":w<CR>";

  nmap.C-s = ":w<CR>";
  imap.abc = ":w<CR>";
  vmap.xyz = ":w<CR>";

  set.number = true;

  use.lsp_signature.setup = callWith {
    bind = true;
    hint_enable = false;
    hi_parameter = "Visual";
    handler_opts.border = "single";
  };

  use."nvim-treesitter.configs".setup = callWith {
    ensure_installed = [ "bash" "c" "css" "javascript" "json" "lua" "nix" "python" "rust" "toml" ];
    highlight = {
      enable = true;
      disable = [ "css" ];
    };
    rainbow = {
      enable = true;
      disable = [ "html" ];
      extended_mode = true;
      max_file_lines = 10000;
      colors = [ "#bd93f9" "#6272a4" "#8be9fd" "#50fa7b" "#f1fa8c" "#ffb86c" "#ff5555" ];
    };
  };

  use.cmp.setup = callWith {
    mapping = [
      { "['<C-n>']" = rawLua "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })"; }
      { "['<C-p>']" = rawLua "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })"; }
      { "['<Down>']" = rawLua "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })"; }
      { "['<Up>']" = rawLua "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })"; }
      { "['<C-d>']" = rawLua "cmp.mapping.scroll_docs(-4)"; }
      { "['<C-f>']" = rawLua "cmp.mapping.scroll_docs(4)"; }
      { "['<C-Space>']" = rawLua "cmp.mapping.complete()"; }
      { "['<C-e>']" = rawLua "cmp.mapping.close()"; }
      { "['<CR>']" = rawLua "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })"; }
    ];
    sources = [
      { name = "nvim_lsp"; }
      { name = "buffer"; }
    ];
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
    relativenumber = true;
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
    pastetoggle = "<leader>v";
    wildmode = "list:longest,list:full";
  };
}
