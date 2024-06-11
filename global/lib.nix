{ inputs, lib, self }:
let
  inherit (inputs) flake-parts;

  # this is a "hack" to get self-modifying flakes without infinite recursion.
  extendFlake = {
    # a flake module to evaluate
    module ? { },

    # the systems to use for the final flake.
    systems ? [ ],
    # a function that can use the evaluated `module` flake to generate the
    # systems for the final flake.
    mkSystems ? (_: systems),

    # the args to use when evaluating the `module` flake.
    args ? { },
    # the args to use when evaluating the final flake.
    finalArgs ? args,
    # a function that can use the evaluated `module` flake to generate the
    # args for the final flake. this allows defining specialArgs that depend
    # on the `module` flake's outputs.
    mkFinalArgs ? (_: finalArgs),

    # a list of modules to extend the `module` flake with.
    modules ? [ ],
    # a function that can use the evaluated `module` flake to generate the
    # modules to extend the final flake with. this allows defining config
    # attributes that depend on the `module` flake's outputs.
    mkModules ? (_: modules),
  }:
  let
    # evaluate the `module` flake.
    flake = flake-parts.lib.mkFlake args { imports = [ module ]; };
  in
  flake-parts.lib.mkFlake (mkFinalArgs flake) ({ lib, ... }: {
    imports = [{ inherit flake; }] ++ (mkModules flake);
    systems = mkSystems flake;
  });

  mkFlake = args: module: extendFlake {
    inherit args;

    module = {
      imports = [
        self.flakeModules.shard
        module
      ];
    };

    mkModules = flake: flake.__global.modules;
  };
in
{ inherit extendFlake mkFlake; }
