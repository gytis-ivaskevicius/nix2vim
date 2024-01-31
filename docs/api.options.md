## _module.args

Additional arguments passed to each module in addition to ones
like `lib`, `config`,
and `pkgs`, `modulesPath`.

This option is also available to all submodules. Submodules do not
inherit args from their parent module, nor do they provide args to
their parent module or sibling submodules. The sole exception to
this is the argument `name` which is provided by
parent modules to a submodule and contains the attribute name
the submodule is bound to, or a unique generated name if it is
not bound to an attribute.

Some arguments are already passed by default, of which the
following *cannot* be changed with this option:
- {var}`lib`: The nixpkgs library.
- {var}`config`: The results of all options after merging the values from all modules together.
- {var}`options`: The options declared in all modules.
- {var}`specialArgs`: The `specialArgs` argument passed to `evalModules`.
- All attributes of {var}`specialArgs`

  Whereas option values can generally depend on other option values
  thanks to laziness, this does not apply to `imports`, which
  must be computed statically before anything else.

  For this reason, callers of the module system can provide `specialArgs`
  which are available during import resolution.

  For NixOS, `specialArgs` includes
  {var}`modulesPath`, which allows you to import
  extra modules from the nixpkgs package tree without having to
  somehow make the module aware of the location of the
  `nixpkgs` or NixOS directories.
  ```
  { modulesPath, ... }: {
    imports = [
      (modulesPath + "/profiles/minimal.nix")
    ];
  }
  ```

For NixOS, the default value for this option includes at least this argument:
- {var}`pkgs`: The nixpkgs package set according to
  the {option}`nixpkgs.pkgs` option.


**Type:** lazy attribute set of raw value
**Default:** ``
**Example:**
```nix

```


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
