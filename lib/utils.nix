{ lib
, vimUtils
, neovim-unwrapped
, bundlerEnv
, writeText
, wrapNeovimUnstable
, stdenv
}:
let
  makeNeovimConfig =
    { neovim ? neovim-unwrapped
    , python3 ? null
    , nodejs ? null
    , binPath ? lib.optionals (nodejs != null) [ nodejs ]
    , lua ? neovim.lua # Changing this variale should be avoided

    , extraPython3Packages ? (_: [ ])
    , extraLuaPackages ? (_: [ ])

    , plugins ? [ ]
    , optionalPlugins ? [ ]

      # for forward compability, when adding new environments, haskell etc.
    , ...
    }@args:
    let
      luaEnv = lua.withPackages extraLuaPackages;

      getDeps = attrname: map (plugin: plugin.${attrname} or (_: [ ]));

      pluginPython3Packages = getDeps "python3Dependencies" (plugins ++ optionalPlugins);

      python3Env = python3.withPackages (ps: [ ps.pynvim ]
        ++ (extraPython3Packages ps)
        ++ (lib.concatMap (f: f ps) pluginPython3Packages));

      enabledRuntimes = {
        ruby = false;
        python = false;
        python3 = python3 != null;
        node = nodejs != null;
      };

    in
    {
      inherit
        enabledRuntimes
        lua
        luaEnv
        neovim
        nodejs
        optionalPlugins
        plugins
        python3
        python3Env
        ;

      pluginsScript = writeText "init.lua" (nativeImpl {
        packages = {
          abc = { start = plugins; opt = optionalPlugins; };
        };
        inherit python3Env;
      });

      env.PATH = binPath;
    };


  transitiveClosure = plugin:
    [ plugin ] ++ (
      lib.unique (builtins.concatLists (map transitiveClosure plugin.dependencies or [ ]))
    );

  findDependenciesRecursively = plugins: lib.concatMap transitiveClosure plugins;

  trace = it: builtins.trace it it;

  link = plugin: packageName: dir:
    if plugin ? luaModule
    then ''
      mkdir -p $out/pack/${packageName}/${dir}/${plugin.pname}/lua
      ln -sf ${plugin}/share/lua/5.1/* $out/pack/${packageName}/${dir}/${plugin.pname}/lua
      ln -sf ${plugin}/${plugin.pname}-${plugin.version}-rocks/${plugin.pname}/${plugin.version}/* $out/pack/${packageName}/${dir}/${plugin.pname}/
    ''
    else "ln -sf ${plugin} $out/pack/${packageName}/${dir}";

  nativeImpl = { packages, python3Env ? null }:
    (
      let

        packageLinks = (packageName: { start ? [ ], opt ? [ ] }:
          let
            depsOfOptionalPlugins = lib.subtractLists opt (findDependenciesRecursively opt);
            startWithDeps = findDependenciesRecursively start;
            allPlugins = lib.unique (startWithDeps ++ depsOfOptionalPlugins);
          in
          [ "mkdir -p $out/pack/${packageName}/{start,opt}" ]
          # To avoid confusion, even dependencies of optional plugins are added
          # to `start` (except if they are explicitly listed as optional plugins).
          ++ (builtins.map (x: link x packageName "start") allPlugins)
          ++ (builtins.map (x: link x packageName "opt") opt)
          # Assemble all python3 dependencies into a single `site-packages` to avoid doing recursive dependency collection
          # for each plugin.
          # This directory is only for python import search path, and will not slow down the startup time.
          ++ lib.optionals (python3Env != null) [
            "mkdir -p $out/pack/${packageName}/start/__python3_dependencies"
            "ln -s ${python3Env}/${python3Env.sitePackages} $out/pack/${packageName}/start/__python3_dependencies/python3"
          ]
        );

        packDir = stdenv.mkDerivation {
          name = "vim-pack-dir";
          src = ./.;
          installPhase = (lib.concatStringsSep "\n" (lib.flatten (lib.mapAttrsToList packageLinks packages)));
          preferLocalBuild = true;
        };
      in
      ''
        local set = vim.opt
        set.packpath:append('${packDir}')
        set.runtimepath:append('${packDir}')
      ''
    );

in
{
  inherit makeNeovimConfig;
}

