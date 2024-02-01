## drvSuffix

Suffix of generated neovim derivation


**Type:** string

**Default:** `"-nix2vim"`

**Example:**
```nix
"-my-awesome-neovim-distribution"
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

**Default:** `"_: [ ]"`

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

**Default:** `"_: [ ]"`

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

**Default:** `"pkgs.neovim-unwrapped"`

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


## packages.\<name\>.opt

Optional plugins


**Type:** list of package

**Default:** `[ ]`

**Example:**
```nix
with pkgs.vimPlugins; [ dracula-vim ]

```


## packages.\<name\>.start

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
