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


## drv

This option contains the store path that represents neovim.

**Type:** package
**Default:** ``
**Example:**
```nix

```


## drvSuffix

Suffix of generated neovim derivation

**Type:** string
**Default:** `"-nix2vim"`
**Example:**
```nix

```


## enableViAlias

Whether to enable 'vi' alias.

**Type:** boolean
**Default:** `false`
**Example:**
```nix
true
```


## enableVimAlias

Whether to enable 'vim' alias.

**Type:** boolean
**Default:** `false`
**Example:**
```nix
true
```


## extraLuaPackages

The function you would have passed to lua.withPackages

**Type:** function that evaluates to a(n) list of package
**Default:** `<function>`
**Example:**
```nix
it: [ it.cjson ]

```


## extraMakeWrapperArgs

Should contain all args but the binary. https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh

**Type:** string
**Default:** `""`
**Example:**
```nix
"--set PATH ${pkgs.lib.makeBinPath [pkgs.ripgrep pkgs.fd]}";
```


## extraPython3Packages

The function you would have passed to python.withPackages

**Type:** function that evaluates to a(n) list of package
**Default:** `<function>`
**Example:**
```nix
it: [ it.requests ]

```


## optionalPlugins

Optional plugins

**Type:** list of package
**Default:** `[ ]`
**Example:**
```nix
with pkgs.vimPlugins; [ dracula-vim ]

```


## package

Neovim package to use.

**Type:** package
**Default:** `<derivation neovim-unwrapped-0.9.5>`
**Example:**
```nix
pkgs.neovim-unwrapped
```


## packages

Attributes gets passed to 'configure.packages'

**Type:** attribute set of (submodule)
**Default:** `{ }`
**Example:**
```nix
with pkgs.vimPlugins; {
  start = [ ];
  opt = [];
};

```


## packages.<name>.opt

Optional plugins

**Type:** list of package
**Default:** `[ ]`
**Example:**
```nix
with pkgs.vimPlugins; [ dracula-vim ]

```


## packages.<name>.start

Plugins to be autoloaded

**Type:** list of package
**Default:** `[ ]`
**Example:**
```nix
with pkgs.vimPlugins; [ dracula-vim ]

```


## plugins

Plugins to be autoloaded

**Type:** list of package
**Default:** `[ ]`
**Example:**
```nix
with pkgs.vimPlugins; [ dracula-vim ]

```


## withNodeJs

Whether to enable Node.js.

**Type:** boolean
**Default:** `false`
**Example:**
```nix
true
```


## withPython3

Whether to enable Python 3.

**Type:** boolean
**Default:** `false`
**Example:**
```nix
true
```


## withRuby

Whether to enable Ruby.

**Type:** boolean
**Default:** `false`
**Example:**
```nix
true
```
