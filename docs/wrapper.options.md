## _module.args
Additional arguments passed to each module in addition to ones
like <literal>lib</literal>, <literal>config</literal>,
and <literal>pkgs</literal>, <literal>modulesPath</literal>.
</para>
<para>
This option is also available to all submodules. Submodules do not
inherit args from their parent module, nor do they provide args to
their parent module or sibling submodules. The sole exception to
this is the argument <literal>name</literal> which is provided by
parent modules to a submodule and contains the attribute name
the submodule is bound to, or a unique generated name if it is
not bound to an attribute.
</para>
<para>
Some arguments are already passed by default, of which the
following <emphasis>cannot</emphasis> be changed with this option:
<itemizedlist>
 <listitem>
  <para>
   <varname>lib</varname>: The nixpkgs library.
  </para>
 </listitem>
 <listitem>
  <para>
   <varname>config</varname>: The results of all options after merging the values from all modules together.
  </para>
 </listitem>
 <listitem>
  <para>
   <varname>options</varname>: The options declared in all modules.
  </para>
 </listitem>
 <listitem>
  <para>
   <varname>specialArgs</varname>: The <literal>specialArgs</literal> argument passed to <literal>evalModules</literal>.
  </para>
 </listitem>
 <listitem>
  <para>
   All attributes of <varname>specialArgs</varname>
  </para>
  <para>
   Whereas option values can generally depend on other option values
   thanks to laziness, this does not apply to <literal>imports</literal>, which
   must be computed statically before anything else.
  </para>
  <para>
   For this reason, callers of the module system can provide <literal>specialArgs</literal>
   which are available during import resolution.
  </para>
  <para>
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
</programlisting>
  </para>
 </listitem>
</itemizedlist>
</para>
<para>
For NixOS, the default value for this option includes at least this argument:
<itemizedlist>
 <listitem>
  <para>
   <varname>pkgs</varname>: The nixpkgs package set according to
   the <option>nixpkgs.pkgs</option> option.
  </para>
 </listitem>
</itemizedlist>


*_Type_*:
lazy attribute set of raw value






## drv
This option contains the store path that represents neovim.

*_Type_*:
package






## drvSuffix
Suffix of generated neovim derivation

*_Type_*:
string


*_Default_*
```
"-skooter"
```




## enableViAlias
Whether to enable 'vi' alias.

*_Type_*:
boolean


*_Default_*
```
false
```


*_Example_*
```
true
```


## enableVimAlias
Whether to enable 'vim' alias.

*_Type_*:
boolean


*_Default_*
```
false
```


*_Example_*
```
true
```


## extraLuaPackages
The function you would have passed to lua.withPackages

*_Type_*:
function that evaluates to a(n) list of package


*_Default_*
```
"<function>"
```


*_Example_*
```
{"_type":"literalExpression","text":"it: [ it.cjson ]\n"}
```


## extraMakeWrapperArgs
Should contain all args but the binary. https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh

*_Type_*:
string


*_Default_*
```
""
```


*_Example_*
```
"--set ABC 123"
```


## extraPython3Packages
The function you would have passed to python.withPackages

*_Type_*:
function that evaluates to a(n) list of package


*_Default_*
```
"<function>"
```


*_Example_*
```
{"_type":"literalExpression","text":"it: [ it.requests ]\n"}
```


## optionalPlugins
Optional plugins

*_Type_*:
list of package


*_Default_*
```
[]
```


*_Example_*
```
{"_type":"literalExpression","text":"with pkgs.vimPlugins; [ dracula-vim ]\n"}
```


## package
Neovim package to use.

*_Type_*:
package


*_Default_*
```
{"_type":"derivation","name":"neovim-unwrapped-0.7.0"}
```


*_Example_*
```
{"_type":"literalExpression","text":"pkgs.neovim-unwrapped"}
```


## packages
Attributes gets passed to 'configure.packages'

*_Type_*:
attribute set of submodule


*_Default_*
```
{}
```


*_Example_*
```
{"_type":"literalExpression","text":"with pkgs.vimPlugins; {\n  start = [ ];\n  opt = [];\n};\n"}
```


## packages.\<name\>.opt
Optional plugins

*_Type_*:
list of package


*_Default_*
```
[]
```


*_Example_*
```
{"_type":"literalExpression","text":"with pkgs.vimPlugins; [ dracula-vim ]\n"}
```


## packages.\<name\>.start
Plugins to be autoloaded

*_Type_*:
list of package


*_Default_*
```
[]
```


*_Example_*
```
{"_type":"literalExpression","text":"with pkgs.vimPlugins; [ dracula-vim ]\n"}
```


## plugins
Plugins to be autoloaded

*_Type_*:
list of package


*_Default_*
```
[]
```


*_Example_*
```
{"_type":"literalExpression","text":"with pkgs.vimPlugins; [ dracula-vim ]\n"}
```


## withNodeJs
Whether to enable Node.js.

*_Type_*:
boolean


*_Default_*
```
false
```


*_Example_*
```
true
```


## withPython3
Whether to enable Python 3.

*_Type_*:
boolean


*_Default_*
```
false
```


*_Example_*
```
true
```


## withRuby
Whether to enable Ruby.

*_Type_*:
boolean


*_Default_*
```
false
```


*_Example_*
```
true
```


