## cmap

Defines 'Command-line mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## cnoremap

Defines 'Command-line mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## function

Attribute set representing <function-name> -> <function-body> pairs


**Type:** attribute set of string

**Default:** `{ }`

**Example:**
```nix
{
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
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## inoremap

Defines 'Insert and Replace mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## lua

Lua config


**Type:** strings concatenated with "\n"

**Default:** `""`

**Example:**
```nix

```


## lua'

Lua config which is placed after `lua` script. Unfortunatelly sometimes config requires certain ordering


**Type:** strings concatenated with "\n"

**Default:** `""`

**Example:**
```nix

```


## nmap

Defines 'Normal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## nnoremap

Defines 'Normal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## omap

Defines 'Operator pending mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## onoremap

Defines 'Operator pending mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
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

```


## smap

Defines 'Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## snoremap

Defines 'Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## tmap

Defines 'Terminal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## tnoremap

Defines 'Terminal mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## use

Allows requiring modules. Gets parset to "require('<name>').<attrs>"


**Type:** attribute set of (attribute set)

**Default:** `{ }`

**Example:**
```nix

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

```


## vimscript'

Vimscript  config which is placed after `lua` script. Unfortunatelly sometimes config requires certain ordering


**Type:** strings concatenated with "\n"

**Default:** `""`

**Example:**
```nix

```


## vmap

Defines 'Visual and Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## vnoremap

Defines 'Visual and Select mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## xmap

Defines 'Visual mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```


## xnoremap

Defines 'Visual mode' mappings


**Type:** attribute set of (null or string)

**Default:** `{ }`

**Example:**
```nix
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```
