## _module.args
Additional arguments passed to each module in addition to ones
like <literal>lib</literal>, <literal>config</literal>,
and <literal>pkgs</literal>, <literal>modulesPath</literal>.

This option is also available to all submodules. Submodules do not
inherit args from their parent module, nor do they provide args to
their parent module or sibling submodules. The sole exception to
this is the argument <literal>name</literal> which is provided by
parent modules to a submodule and contains the attribute name
the submodule is bound to, or a unique generated name if it is
not bound to an attribute.

Some arguments are already passed by default, of which the
following <emphasis>cannot</emphasis> be changed with this option:

<itemizedlist>
<listitem><para><varname>lib</varname>: The nixpkgs library.

</para></listitem>
<listitem><para><varname>config</varname>: The results of all options after merging the values from all modules together.

</para></listitem>
<listitem><para><varname>options</varname>: The options declared in all modules.

</para></listitem>
<listitem><para><varname>specialArgs</varname>: The <literal>specialArgs</literal> argument passed to <literal>evalModules</literal>.

</para></listitem>
<listitem><para>All attributes of <varname>specialArgs</varname>

Whereas option values can generally depend on other option values
thanks to laziness, this does not apply to <literal>imports</literal>, which
must be computed statically before anything else.

For this reason, callers of the module system can provide <literal>specialArgs</literal>
which are available during import resolution.

For NixOS, <literal>specialArgs</literal> includes
<varname>modulesPath</varname>, which allows you to import
extra modules from the nixpkgs package tree without having to
somehow make the module aware of the location of the
<literal>nixpkgs</literal> or NixOS directories.

<programlisting>
{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/profiles/minimal.nix")
  ];
}
</programlisting></para></listitem>

</itemizedlist>For NixOS, the default value for this option includes at least this argument:

<itemizedlist>
<listitem><para><varname>pkgs</varname>: The nixpkgs package set according to
the <option>nixpkgs.pkgs</option> option.</para></listitem>

</itemizedlist>


*_Type_*:
lazy attribute set of raw value






## cmap
Defines 'Command-line mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## cnoremap
Defines 'Command-line mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## function
Attribute set representing <function-name> -> <function-body> pairs

*_Type_*:
attribute set of string


*_Default_*
```
{}
```


*_Example_*
```
{"abc":"print 'hello world'"}
```


## imap
Defines 'Insert and Replace mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## inoremap
Defines 'Insert and Replace mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## lua
Lua config

*_Type_*:
strings concatenated with "\n"


*_Default_*
```
""
```




## nmap
Defines 'Normal mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## nnoremap
Defines 'Normal mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## omap
Defines 'Operator pending mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## onoremap
Defines 'Operator pending mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## set
'vim.opt' alias. Acts same as vimscript 'set' command

*_Type_*:
attribute set of (boolean or floating point number or signed integer or string)


*_Default_*
```
{}
```


*_Example_*
```
{"set":{"clipboard":"unnamed,unnamedplus","termguicolors":true}}
```


## setup
Results in 'require(<name>).setup(<attrs>)'.

*_Type_*:
attribute set of (attribute set)


*_Default_*
```
{}
```




## smap
Defines 'Select mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## snoremap
Defines 'Select mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## tmap
Defines 'Terminal mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## tnoremap
Defines 'Terminal mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## use
Allows requiring modules. Gets parset to "require('<name>').<attrs>"

*_Type_*:
attribute set of (attribute set)


*_Default_*
```
{}
```




## vim
Represents 'vim' namespace from neovim lua api.

*_Type_*:
attribute set


*_Default_*
```
{}
```


*_Example_*
```
{"vim":{"opt":{"clipboard":"unnamed,unnamedplus","termguicolors":true}}}
```


## vimscript
Vimscript config

*_Type_*:
strings concatenated with "\n"


*_Default_*
```
""
```




## vmap
Defines 'Visual and Select mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## vnoremap
Defines 'Visual and Select mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## xmap
Defines 'Visual mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


## xnoremap
Defines 'Visual mode' mappings

*_Type_*:
attribute set of (null or string)


*_Default_*
```
{}
```


*_Example_*
```
{"C-p":":FZF<CR>","abc":":FZF<CR>"}
```


