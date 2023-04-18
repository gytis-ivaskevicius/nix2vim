{ pkgs, dsl, ... }: with dsl; {

  plugins = with pkgs.vimPlugins; [
    rust-tools-nvim
    # for updating rust crates
    crates-nvim
  ];

  setup.rust-tools = {
    tools = {
      autoSetHints = true;
      runnables.use_telescope = true;
      inlay_hints = {
        only_current_line = false;
        only_current_line_autocmd = "CursorMoved";

        show_parameter_hints = true;

        parameter_hints_prefix = "<- ";
        other_hints_prefix = "=> ";

        max_len_align = false;

        max_len_align_padding = 1;

        right_align = false;

        right_align_padding = 7;
        highlight = "DiagnosticSignWarn";
      };
    };
    server.cmd = [ "${pkgs.rust-analyzer}/bin/rust-analyzer" ];
  };

  setup.crates = {
    text = {
      loading = "  Loading...";
      version = "  %s";
      prerelease = "  %s";
      yanked = "  %s yanked";
      nomatch = "  Not found";
      upgrade = "  %s";
      error = "  Error fetching crate";
    };
    popup = {
      text = {
        title = " # %s ";
        version = " %s ";
        prerelease = " %s ";
        yanked = " %s yanked ";
        feature = "   %s ";
        enabled = " * %s ";
        transitive = " ~ %s ";
      };
    };
  };

  use.lspconfig.rust_analyzer.setup = callWith {
    cmd = [ "${pkgs.rust-analyzer}/bin/rust-analyzer" ];
    capabilities = rawLua "capabilities";
    settings."['rust-analyzer']" = { procMacro.enable = true; };
  };
}

