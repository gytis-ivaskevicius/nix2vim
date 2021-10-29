# nix2vim

Super WIP Nix -> neovim lua configuration parser.
Usage example: https://github.com/DieracDelta/vimconf_talk/tree/5_ci

APIs that need to be implemented: (6-10 points are super simple)
~1. set~~
~2. require~~
3. lsp (first class LSP support)
~4. mappings~~
5. autocmd
6. setup (`setup.<name> = {a = 1;}` should be parsed to `require('<name>').setup {a = 1}`. Basically existing `require` API wrapper)
7. globals (same as `set` wrapper but for `let g:xyz` stuff)
8. leader option
9. source lua/vim files
10. functions definition
