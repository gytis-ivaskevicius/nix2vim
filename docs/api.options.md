## cmap

Defines 'Command-line mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  RH = "Gitsigns reset_hunk";
}
```


## cnoremap

Defines 'Command-line mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  RH = "Gitsigns reset_hunk";
}
```


## function

Attribute set representing <function-name> -> <function-body> pairs


**Type:** attribute set of string

**Default:** `{ }`

**Example:**
```nix
{
  # Gets parsed to:
  # function abc()
  #   print 'hello world'
  # end
  abc = "print 'hello world'";
}

```


## imap

Defines 'Insert and Replace mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<C-BS>" = "<C-W>";
  "<C-h>" = "<Left>";
  "<C-j>" = "<Down>";
  "<C-k>" = "<Up>";
  "<C-l>" = "<Right>";
}
```


## inoremap

Defines 'Insert and Replace mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<C-BS>" = "<C-W>";
  "<C-h>" = "<Left>";
  "<C-j>" = "<Down>";
  "<C-k>" = "<Up>";
  "<C-l>" = "<Right>";
}
```


## lua

Lua config


**Type:** strings concatenated with "\n"

**Default:** `""`

**Example:**
```nix
''
  local hooks = require "ibl.hooks"
  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )
''
```


## lua'

Lua config which is placed after `lua` script. Unfortunatelly sometimes config requires certain ordering


**Type:** strings concatenated with "\n"

**Default:** `""`

**Example:**
```nix
''
  local hooks = require "ibl.hooks"
  hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
  )
''
```


## nmap

Defines 'Normal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<leader>/" = ":nohl<cr>";
}
```


## nnoremap

Defines 'Normal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<leader>/" = ":nohl<cr>";
}
```


## omap

Defines 'Operator pending mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  imma-be-real-with-ya = "I have no idea what for one may use this";
}
```


## onoremap

Defines 'Operator pending mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  imma-be-real-with-ya = "I have no idea what for one may use this";
}
```


## set

'vim.opt' alias. Acts same as vimscript 'set' command


**Type:** attribute set of (boolean or floating point number or signed integer or string)

**Default:** `{ }`

**Example:**
```nix
{
  set = {
    clipboard = "unnamed,unnamedplus";
    termguicolors = true;
  };
}
```


## setup

Results in 'require(<name>).setup(<attrs>)'.


**Type:** attribute set of (attribute set)

**Default:** `{ }`

**Example:**
```nix
setup.lsp_signature = {
  bind = true;
  hint_enable = false;
  hi_parameter = "Visual";
  handler_opts.border = "single";
};

```


## smap

Defines 'Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<CR>" = "a<BS>";
}
```


## snoremap

Defines 'Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<CR>" = "a<BS>";
}
```


## tmap

Defines 'Terminal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<Esc>" = "<C-><C-n>";
}
```


## tnoremap

Defines 'Terminal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<Esc>" = "<C-><C-n>";
}
```


## use

Allows requiring modules. Gets parset to "require('<name>').<attrs>"


**Type:** attribute set of (attribute set)

**Default:** `{ }`

**Example:**
```nix
use.which-key.register = dsl.callWith {
  q = cmd "bdelete" "Delete buffer";
}

```


## vim

Represents 'vim' namespace from neovim lua api.


**Type:** anything

**Default:** `{ }`

**Example:**
```nix
{
  vim = {
    opt = {
      clipboard = "unnamed,unnamedplus";
      termguicolors = true;
    };
  };
}
```


## vimscript

Vimscript config


**Type:** strings concatenated with "\n"

**Default:** `""`

**Example:**
```nix
"set number"
```


## vimscript'

Vimscript config which is placed after `lua` script. Unfortunatelly sometimes config requires certain ordering


**Type:** strings concatenated with "\n"

**Default:** `""`

**Example:**
```nix
"set number"
```


## vmap

Defines 'Visual and Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<" = "<gv";
  ">" = ">gv";
}
```


## vnoremap

Defines 'Visual and Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<" = "<gv";
  ">" = ">gv";
}
```


## xmap

Defines 'Visual mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<" = "<gv";
  ">" = ">gv";
}
```


## xnoremap

Defines 'Visual mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  "<" = "<gv";
  ">" = ">gv";
}
```
