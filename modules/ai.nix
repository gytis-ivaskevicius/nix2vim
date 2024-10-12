{
  pkgs,
  lib,
  dsl,
  ...
}:
let

  codeium = pkgs.vimUtils.buildVimPlugin {
    name = "codeium";
    src = pkgs.fetchFromGitHub {
      owner = "Exafunction";
      repo = "codeium.nvim";
      rev = "ca38490ef963b066d6f686146d73213c70ef7f6b";
      sha256 = "sha256-fsqtdu4ilQ9mYb/BJT4nhqzvCGnrkWnVF9QQRNFdQHk=";
    };
  };
  codegpt = pkgs.vimUtils.buildVimPlugin {
    name = "codegpt";
    src = pkgs.fetchFromGitHub {
      owner = "dpayne";
      repo = "CodeGPT.nvim";
      rev = "9d0a58a0bdc858f2e9729b8b5ac8b994c3453c8f";
      sha256 = "sha256-mUThyaEy3Vtv0YgbIyjY+6sJHfMz80nBooTWxQe3xlM=";
    };
  };
in
{
  plugins = with pkgs.vimPlugins; [
    codeium
    nui-nvim
    codegpt
  ];

  setup.codeium = {
    language_server = "${pkgs.codeium}/bin/codeium_language_server";
  };

  use.codegpt = {
    max_tokens = 128000;
  };

  vim.g.codegpt_global_commands_defaults = dsl.toTable {
    model = "gpt-4o";
  };

  vim.g.codegpt_commands = dsl.toTable {
    "['code_edit']".language_instructions = {
      typescript = "Use the latest version of Typescript and React. Avoid the use of global state, and the any type.";
      javascript = "Use the latest features of Javascript and the latest version of React. Avoid the use of global state, and the any type.";
      nix = "Avoid duplicate keys, prefer dot notation for nested attribute sets.";
    };

    "['fix']".user_message_template = ''
      I have the following {{language}} code: ```{{filetype}}
      {{text_selection}}```
      Refine this code by identifying and correcting any errors or bugs that may be present.
    '';
  };
}
