## enableViAlias



Whether to enable ‘vi’ alias\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## enableVimAlias



Whether to enable ‘vim’ alias\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## package



Neovim package to use\.



*Type:*
package



*Default:*
` <derivation neovim-unwrapped-0.9.5> `



*Example:*
` pkgs.neovim-unwrapped `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## packages



Attributes gets passed to ‘configure\.packages’



*Type:*
attribute set of (submodule)



*Default:*
` { } `



*Example:*

```
with pkgs.vimPlugins; {
  start = [ ];
  opt = [];
};

```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## packages\.\<name>\.opt



Optional plugins



*Type:*
list of package



*Default:*
` [ ] `



*Example:*

```
with pkgs.vimPlugins; [ dracula-vim ]

```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## packages\.\<name>\.start



Plugins to be autoloaded



*Type:*
list of package



*Default:*
` [ ] `



*Example:*

```
with pkgs.vimPlugins; [ dracula-vim ]

```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



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



## drv



This option contains the store path that represents neovim\.



*Type:*
package *(read only)*

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## drvSuffix



Suffix of generated neovim derivation



*Type:*
string



*Default:*
` "-nix2vim" `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## extraLuaPackages



The function you would have passed to lua\.withPackages



*Type:*
function that evaluates to a(n) list of package



*Default:*
` <function> `



*Example:*

```
it: [ it.cjson ]

```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## extraMakeWrapperArgs



Should contain all args but the binary\. https://github\.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper\.sh



*Type:*
string



*Default:*
` "" `



*Example:*
` "--set ABC 123" `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## extraPython3Packages



The function you would have passed to python\.withPackages



*Type:*
function that evaluates to a(n) list of package



*Default:*
` <function> `



*Example:*

```
it: [ it.requests ]

```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## optionalPlugins



Optional plugins



*Type:*
list of package



*Default:*
` [ ] `



*Example:*

```
with pkgs.vimPlugins; [ dracula-vim ]

```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## plugins



Plugins to be autoloaded



*Type:*
list of package



*Default:*
` [ ] `



*Example:*

```
with pkgs.vimPlugins; [ dracula-vim ]

```

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## withNodeJs



Whether to enable Node\.js\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## withPython3



Whether to enable Python 3\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)



## withRuby



Whether to enable Ruby\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `

*Declared by:*
 - [/nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper\.options\.nix](file:///nix/store/mcssnwfdfsq4hw96x39kciqmv7ndvc59-source/lib/wrapper.options.nix)


