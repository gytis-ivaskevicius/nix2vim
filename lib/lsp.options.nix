{ pkgs, config, lib, dsl, ... }: with dsl;
let
  inherit (lib) getExe types mkOption mapAttrs;
  cfg = config.lspconfig;
  capabilities = rawLua "capabilities";
in
{

  options.lspconfig = {
    enable = lib.mkEnableOption "LspConfig";

    capabilities = lib.mkOption {
      type = types.listOf types.str;
      description = "List of attribute set of capabilities which get mered using `vim.tbl_deep_extend` with behavior 'force'";
      default = [
        "vim.lsp.protocol.make_client_capabilities()"
        "require('cmp_nvim_lsp').default_capabilities()"
        "{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }"
      ];
      example = literalExpression ''
        [
          "vim.lsp.protocol.make_client_capabilities()"
          "require('cmp_nvim_lsp').default_capabilities()"
          # File watching is disabled by default for neovim.
          # See: https://github.com/neovim/neovim/pull/22405
          "{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }"
        ]
      '';
    };


    lsp = mkOption {
      type = types.attrsOf types.attrs;
      description = ''
        Configures defined Lsp's using lspconfig, attaches capabilities defined by `lspconfig.capabilities` and wraps `on_attach` argument if defined in a funchtion such as:

        ```lua
        function(client, bufnr)
          ''${on_attach}
        end
        ```
      '';
      example = {
        tsserver = literalExpression ''
          {
            cmd = [ (lib.getExe pkgs.nodePackages.typescript-language-server) "--stdio" ];
            filetypes = [ "json" "javascript" "javascriptreact" "javascript.jsx" "typescript" "typescriptreact" "typescript.tsx" ];
            on_attach = '''
              print("Hello world from your LSP!!!")
            ''';
          };
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];

    use.lspconfig = mapAttrs
      (_: value: {
        setup = dsl.callWith ({ inherit capabilities; }
          // value
          // lib.optionalAttrs (value ? on_attach) {
          on_attach = dsl.rawLua ''
            function(client, bufnr)
              ${value.on_attach}
            end
          '';
        });
      })
      cfg.lsp;

    lua = ''
      local capabilities = vim.tbl_deep_extend(
        'force',
        ${lib.concatStringsSep ",\n  " cfg.capabilities}
      );
    '';

  };


}
