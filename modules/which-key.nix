{ pkgs, lib, dsl, ... }: with dsl;
let
  cmd = command: desc: [ "<cmd>${command}<cr>" desc ];
  cmdLua = command: (cmd "lua ${command}");
in
{

  plugins = with pkgs.vimPlugins; [
    # command discover
    which-key-nvim
  ];

  vimscript = ''
    autocmd BufDelete * if len(filter(range(1, bufnr('$')), '! empty(bufname(v:val)) && buflisted(v:val)')) == 1 | quit | endif
  '';

  setup.which-key = {
    window.padding = [ 1 1 1 1 ];
    layout = {
      height.max = 40;
      width.max = 70;
      align = "center";
    };
  };
  use.which-key.register = dsl.callWith {
    K = cmdLua "show_documentation()" "Get Type Information";
    q = cmd "bdelete" "Delete buffer";

    g = {
      name = "Gitsigns";

      b = cmd "Gitsigns blame_line" "Blame line";
      c = cmd "Gitsigns next_hunk" "Next hunk";
      n = cmd "Gitsigns next_hunk" "Next hunk";
      p = cmd "Gitsigns prev_hunk" "Prev hunk";
      s = cmd "Gitsigns preview_hunk" "Preview hunk";
    };

    "['<leader>']" = {
      name = "+leader_bindings";

      D = cmdLua "vim.lsp.buf.declaration()" "Jump to Declaration";
      d = cmdLua "vim.lsp.buf.definition()" "Jump to Definition";
      i = cmdLua "vim.lsp.buf.implementation()" "Jump to Implementation";
      s = cmdLua "vim.lsp.buf.signature_help()" "Get function signature";

      k = cmdLua "vim.lsp.buf.type_definition()" "Get type definition";
      rn = cmdLua "vim.lsp.buf.rename()" "Rename function/variable";
      ca = cmdLua "vim.lsp.buf.code_action()" "Perform code action";
      r = cmdLua "vim.lsp.buf.references()" "Get function/variable refs";
      e = cmdLua "vim.diagnostic.open_float()" "Get lsp errors";
      dn = cmdLua "vim.diagnostic.goto_next()" "next diag";
      dp = cmdLua "vim.diagnostic.goto_prev()" "prev diag";
      f = cmdLua "vim.lsp.buf.formatting()" "Format buffer";

      "['<leader>']" = [ "<cmd>Telescope find_files<cr>" "search files" ];
      bb = cmd "Telescope buffers" "Get buffer list";
      fb = cmd "Telescope file_browser" "Get buffer list";
      gf = cmd "lua require('telescope.builtins').live_grep {default_text='function'}" "grep for functions only";
      gg = cmd "Telescope live_grep" "Fzf fuzzy search";
      l = cmd "Telescope resume" "last telescope query";

      n = cmd "bnext" "Next buffer";
      p = cmd "bprev" "Previous buffer";
      gs = cmd "lua require('neogit').open()" "Open neogit (magit clone)";
      wd = cmd "q" "Delete window";
      ws = cmd "sp" "Split window horizontally";
      wv = cmd "vs" "Split window vertically";



      c = {
        name = "Crates";
        U = cmdLua "require('crates').upgrade_crate()" "upgrade a crate";
        Ua = cmdLua "require('crates').upgrade_all_crates()" "upgrade all crates";
        u = cmdLua "require('crates').update_crate()" "update a crate";
        ua = cmdLua "require('crates').update_all_crates()" "update all crates";
      };


      rJ = cmdLua "require'rust-tools.join_lines'.join_lines()" "Join lines rust";
      rh = cmdLua "require('rust-tools.inlay_hints').toggle_inlay_hints()" "Toggle inlay type hints";
      rm = cmdLua "require'rust-tools.expand_macro'.expand_macro()" "Expand macro";
      rpm = cmdLua "require'rust-tools.parent_module'.parent_module()" "Go to parent module";



    };
  };

}
