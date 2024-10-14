{ pkgs
, lib
, dsl
, ...
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
  avante = pkgs.vimPlugins.avante-nvim.overrideAttrs (_: {
    src = pkgs.fetchFromGitHub {
      owner = "yetone";
      repo = "avante.nvim";
      rev = "347d9be730546d3cb55ed32b972fa597aa9b436f";
      sha256 = "sha256-wlqLxYB6QjFOf81/OjW6fg4xsAnueu+6qUmwkvMMk90=";
    };
  });
in
{
  plugins = with pkgs.vimPlugins; [
    codeium
    nui-nvim
    codegpt
    avante
    dressing-nvim
  ];

  setup.codeium = {
    language_server = "${pkgs.codeium}/bin/codeium_language_server";
  };

  setup.avante = {
    provider = "openai";
    behaviour.auto_apply_diff_after_generation = true;
  };

  use.avante_lib.load = dsl.callWith null;

  use.codegpt = { };

  vim.g.codegpt_global_commands_defaults = dsl.toTable {
    model = "gpt-4o";
    max_tokens = 16384;
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
