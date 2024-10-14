{ pkgs, dsl, ... }: with dsl;{

  plugins = with pkgs.vimPlugins; [
    surround-nvim
    nvim-autopairs

    # Not available in nixpkgs :/
    #guess-indent
  ];

  setup.nvim-autopairs = { };
  setup.surround.prefix = "S";

  set = {
    confirm = true;
    cursorline = true;
    laststatus = 3;
    matchpairs = "(:),{:},[:],<:>";
    mouse = "a";
    number = true;
    scrolloff = 15;
    showmatch = true;
    sidescrolloff = 15;
    smartcase = true;
    smartindent = true;
    splitbelow = true;
    splitright = true;
    swapfile = false;
    termguicolors = true;
    undofile = true;
    wildignore = "*/tmp/*,*.so,*.swp,*.pyc,*.db,*.sqlite,*.class,*/node_modules/*,*/.git/*";
    wildmode = "list:longest,list:full";
    wrap = false;
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
  };

  vim.g = {
    mapleader = " ";
    completeopt = "menu,menuone,noselect";
  };

  #cmap.messagescp = ":let @+=execute('messages')<CR>";
  # Clear highlight
  nmap."<leader>/" = ":nohl<cr>";

  # Ctrl + hjkl - in insert to move between characters
  inoremap."<C-h>" = "<Left>";
  inoremap."<C-j>" = "<Down>";
  inoremap."<C-k>" = "<Up>";
  inoremap."<C-l>" = "<Right>";

  # Ctrl + hjkl - in normal mode to move betwen splits,
  nmap."<C-h>" = "<C-w>h";
  nmap."<C-j>" = "<C-w>j";
  nmap."<C-k>" = "<C-w>k";
  nmap."<C-l>" = "<C-w>l";

  # q to quit, Q to record macro
  nnoremap.Q = "q";

  # q to quit, Q to record macro
  vnoremap."<" = "<gv";
  vnoremap.">" = ">gv";

  nmap."<C-c>" = ''"+yy'';
  vmap."<C-c>" = ''"+y'';
  imap."<C-v>" = ''<Esc>"+pa'';

  # Ctrl+Backspace to delete previous word. https://vi.stackexchange.com/questions/16139/s-bs-and-c-bs-mappings-not-working
  inoremap."<C-BS>" = "<C-W>";

  lua = ''
    vim.opt.shortmess:append "sI"
    vim.opt.fillchars = { eob = " " }
    vim.opt.whichwrap:append "<>[]hl"
  '';

  vimscript = ''
    autocmd FileType nix setlocal shiftwidth=2 tabstop=2

    " Function to clean trailing Spaces on save
    function! CleanExtraSpaces() "Function to clean unwanted spaces
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        silent! %s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
    endfun
    autocmd BufWritePre * :call CleanExtraSpaces()


    " Preserve cursor location
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  '';

}
