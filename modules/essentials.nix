{ pkgs, dsl, ... }: with dsl;{

  plugins = with pkgs.vimPlugins; [
    surround-nvim

    # Not available in nixpkgs :/
    #guess-indent
  ];

  setup.surround.prefix = "S";

  set = {
    hidden = true;
    hlsearch = true;
    ignorecase = true;
    list = true;
    listchars = "tab:→→,trail:●,nbsp:○";
    matchpairs = "(:),{:},[:],<:>";
    mouse = "a";
    number = true;
    scrolloff = 15;
    showmatch = true;
    sidescrolloff = 15;
    signcolumn = "yes";
    smartcase = true;
    splitbelow = true;
    splitright = true;
    termguicolors = true;
    #title = true; # Visual artifacts
    undofile = true;
    updatetime = 100;
    visualbell = true;
    wildignore = "*/tmp/*,*.so,*.swp,*.pyc,*.db,*.sqlite,*.class,*/node_modules/*,*/.git/*";
    wildmode = "list:longest,list:full";
    wrap = false;

    expandtab = true;
    shiftwidth = 4;
    smartindent = true;
    softtabstop = 4;
    tabstop = 4;

    #cursorline = true;
  };

  vim.g = {
    mapleader = " ";
    completeopt = "menu,menuone,noselect";
  };

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
  nnoremap.q = ":q<cr>";

  # q to quit, Q to record macro
  vnoremap."<" = "<gv";
  vnoremap.">" = ">gv";

  # Make Y consistent with commands like D,C
  nmap.Y = "y$";

  nmap."<C-c>" = ''"+yy'';
  vmap."<C-c>" = ''"+y'';
  imap."<C-v>" = ''<Esc>"+pa'';

  # Ctrl+Backspace to delete previous word. https://vi.stackexchange.com/questions/16139/s-bs-and-c-bs-mappings-not-working
  inoremap."<C-BS>" = "<C-W>";


  vimscript = ''
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
