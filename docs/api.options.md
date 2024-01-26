## _module\.args

Additional arguments passed to each module in addition to ones
like ` lib `, ` config `,
and ` pkgs `, ` modulesPath `\.

This option is also available to all submodules\. Submodules do not
inherit args from their parent module, nor do they provide args to
their parent module or sibling submodules\. The sole exception to
this is the argument ` name ` which is provided by
parent modules to a submodule and contains the attribute name
the submodule is bound to, or a unique generated name if it is
not bound to an attribute\.

Some arguments are already passed by default, of which the
following *cannot* be changed with this option:

 - ` lib `: The nixpkgs library\.

 - ` config `: The results of all options after merging the values from all modules together\.

 - ` options `: The options declared in all modules\.

 - ` specialArgs `: The ` specialArgs ` argument passed to ` evalModules `\.

 - All attributes of ` specialArgs `
   
   Whereas option values can generally depend on other option values
   thanks to laziness, this does not apply to ` imports `, which
   must be computed statically before anything else\.
   
   For this reason, callers of the module system can provide ` specialArgs `
   which are available during import resolution\.
   
   For NixOS, ` specialArgs ` includes
   ` modulesPath `, which allows you to import
   extra modules from the nixpkgs package tree without having to
   somehow make the module aware of the location of the
   ` nixpkgs ` or NixOS directories\.
   
   ```
   { modulesPath, ... }: {
     imports = [
       (modulesPath + "/profiles/minimal.nix")
     ];
   }
   ```

For NixOS, the default value for this option includes at least this argument:

 - ` pkgs `: The nixpkgs package set according to
   the ` nixpkgs.pkgs ` option\.



*Type:*
lazy attribute set of raw value

*Declared by:*
 - [\<nixpkgs/lib/modules\.nix>](https://github.com/NixOS/nixpkgs/blob//lib/modules.nix)



## cmap



Defines ‘Command-line mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## cnoremap



Defines ‘Command-line mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## function



Attribute set representing \<function-name> -> \<function-body> pairs



*Type:*
attribute set of string



*Default:*
` { } `



*Example:*

```
{
  abc = "print 'hello world'";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## imap



Defines ‘Insert and Replace mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## inoremap



Defines ‘Insert and Replace mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## lua



Lua config



*Type:*
strings concatenated with “\\n”



*Default:*
` "" `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## nmap



Defines ‘Normal mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## nnoremap



Defines ‘Normal mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## omap



Defines ‘Operator pending mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## onoremap



Defines ‘Operator pending mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## set



‘vim\.opt’ alias\. Acts same as vimscript ‘set’ command



*Type:*
attribute set of (boolean or floating point number or signed integer or string)



*Default:*
` { } `



*Example:*

```
{
  set = {
    clipboard = "unnamed,unnamedplus";
    termguicolors = true;
  };
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## setup



Results in ‘require(\<name>)\.setup(\<attrs>)’\.



*Type:*
attribute set of (attribute set)



*Default:*
` { } `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## smap



Defines ‘Select mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## snoremap



Defines ‘Select mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## tmap



Defines ‘Terminal mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## tnoremap



Defines ‘Terminal mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## use



Allows requiring modules\. Gets parset to “require(‘\<name>’)\.\<attrs>”



*Type:*
attribute set of (attribute set)



*Default:*
` { } `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## vim



Represents ‘vim’ namespace from neovim lua api\.



*Type:*
attribute set



*Default:*
` { } `



*Example:*

```
{
  vim = {
    opt = {
      clipboard = "unnamed,unnamedplus";
      termguicolors = true;
    };
  };
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## vimscript



Vimscript config



*Type:*
strings concatenated with “\\n”



*Default:*
` "" `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## vmap



Defines ‘Visual and Select mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## vnoremap



Defines ‘Visual and Select mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## xmap



Defines ‘Visual mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)



## xnoremap



Defines ‘Visual mode’ mappings



*Type:*
attribute set of (null or string)



*Default:*
` { } `



*Example:*

```
{
  C-p = ":FZF<CR>";
  abc = ":FZF<CR>";
}
```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/api.options.nix)


