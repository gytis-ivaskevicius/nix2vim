{ pkgs
, lib
, dsl
, ...
}:
let

  codegpt = pkgs.vimUtils.buildVimPlugin {
    name = "CodeGPT.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "harjotgill";
      repo = "CodeGPT.nvim";
      rev = "cdabcf06e8055b1816e2c3b3d56d500501cfaabe";
      sha256 = "sha256-mUThyaEy3Vtv0YgbIyjY+6sJHfMz80nBooTWxQe3xlM=";
    };
    doCheck = false;
  };
in
{
  plugins = with pkgs.vimPlugins; [
    codeium-nvim
    nui-nvim
    #copilot-vim
    #CopilotChat-nvim
    codegpt
    avante-nvim
    img-clip-nvim
    dressing-nvim
  ];

  setup.codeium = {
    language_server = "${pkgs.codeium}/bin/codeium_language_server";
  };

  setup.avante = {
    provider = "openai";
    openai.model = "gpt-4o";
    rag_service.enabled = true;
  };
  #setup.CopilotChat = {};

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
