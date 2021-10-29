# nix2vim

Super WIP Nix -> neovim lua configuration parser.
Usage example: https://github.com/DieracDelta/vimconf_talk/tree/5_ci

APIs that need to be implemented: (half of these points are super simple)

- [x] set
- [x] require
- [ ] lsp (first class LSP support)
- [x] mappings
- [ ] autocmd
- [ ] setup (`setup.<name> = {a = 1;}` should be parsed to `require('<name>').setup {a = 1}`. Basically existing `require` API wrapper)
- [ ] globals (same as `set` wrapper but for `let g:xyz` stuff)
- [ ] <leader> option
- [ ] source lua/vim files
- [ ] functions definition
