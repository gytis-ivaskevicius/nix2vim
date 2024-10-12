{ pkgs, lib, dsl, ... }: with dsl;
let
  inherit (lib) getExe;
  capabilities = rawLua "capabilities";
  border = highlightName: [
    [ "╭" highlightName ]
    [ "─" highlightName ]
    [ "╮" highlightName ]
    [ "│" highlightName ]
    [ "╯" highlightName ]
    [ "─" highlightName ]
    [ "╰" highlightName ]
    [ "│" highlightName ]
  ];
in
{

  imports = [
    ./rust.nix
  ];

  plugins = with pkgs.vimPlugins; [
    # Completion
    cmp-nvim-lsp
    nvim-cmp
    cmp-buffer
    # Lsp autocompletion thing on the right
    lspkind-nvim
    # Snippets
    luasnip
    cmp_luasnip
    friendly-snippets
    # Function signature
    lsp_signature-nvim
    # Show LSP progress
    fidget-nvim
  ];

  lspconfig.enable = true;

  setup.fidget = {
    progress.display.progress_ttl = 3;
  };

  setup.lsp_signature = {
    bind = true;
    hint_enable = false;
    hi_parameter = "Visual";
    handler_opts.border = "single";
  };

  use."luasnip.loaders.from_vscode".lazy_load = callWith { };

  use.lspkind.init = callWith {
    # defines how annotations are shown
    # default: symbol
    # options: "text", "text_symbol", "symbol_text", "symbol"
    mode = "symbol_text";
  };

  setup.cmp = {
    snippet.expand = dsl.rawLua "function(args) require('luasnip').lsp_expand(args.body) end";
    window = {
      completion = {
        winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None";
        scrollbar = false;
      };
      documentation = {
        border = border "CmpDocBorder";
        winhighlight = "Normal:CmpDoc";
      };
    };

    mapping = {
      "['<C-n>']" = rawLua "cmp.mapping.select_next_item()";
      "['<Down>']" = rawLua "cmp.mapping.select_next_item()";
      "['<C-p>']" = rawLua "cmp.mapping.select_prev_item()";
      "['<Up>']" = rawLua "cmp.mapping.select_prev_item()";
      "['<C-d>']" = rawLua "cmp.mapping.scroll_docs(-4)";
      "['<C-f>']" = rawLua "cmp.mapping.scroll_docs(4)";
      "['<C-Space>']" = rawLua "cmp.mapping.complete()";
      "['<C-e>']" = rawLua "cmp.mapping.close()";
      "['<CR>']" = rawLua "cmp.mapping.confirm()";
      "['<Tab>']" = rawLua ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            fallback()
          end
        end, {"i", "s"})
      '';
      "['<S-Tab>']" = rawLua ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            fallback()
          end
        end, { "i", "s" })
      '';
    };
    sources = [
      { name = "nvim_lsp"; }
      #{ name = "codeium"; }
      { name = "luasnip"; }
      { name = "buffer"; }
      { name = "crates"; }
      { name = "path"; }
    ];
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

  lspconfig.lsp = {

    ts_ls = {
      cmd = [ (getExe pkgs.nodePackages.typescript-language-server) "--stdio" ];
    };

    # No longer in nixpkgs since it is unmaintained
    # rnix = {
    #   cmd = [ (getExe pkgs.rnix-lsp) ];
    # };

    # nil_ls = {
    #   cmd = [ (getExe pkgs.nil) ];
    #   settings = {
    #     "['nil']".nix = {
    #       maxMemoryMB = 8192;
    #       #flake.autoArchive = true;
    #       # Crashes if flake has inputs with invalid outputs
    #       #flake.autoEvalInputs = true;
    #     };
    #   };
    # };

    jsonls = {
      cmd = [ "${pkgs.nodePackages.vscode-json-languageserver}/bin/vscode-json-languageserver" "--stdio" ];
    };

    solargraph = {
      cmd = [ "${pkgs.solargraph}/bin/solargraph" "stdio" ];
    };

    clangd = {
      cmd = [ "${pkgs.clang-tools}/bin/clangd" ];
    };

    gopls = {
      cmd = [ "${pkgs.gopls}/bin/gopls" ];
    };

    pyright = {
      cmd = [ "${pkgs.pyright}/bin/pyright-langserver" "--stdio" ];
    };

    terraformls = {
      cmd = [ "${pkgs.terraform-lsp}/bin/terraform-lsp" ];
    };

  };

}
