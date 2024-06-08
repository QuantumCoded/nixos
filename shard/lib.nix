{ inputs, lib, self }:
let
  inherit (inputs) flake-parts;

  # this is a "hack" to get self-modifying flakes without infinite recursion.
  extendFlake = {
    # a flake module to evaluate
    module ? { },

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
    # the final flake doesn't need systems as config is inherited.
    systems = [ ];
    # import the evaluated `module` flake's outputs and extended modules.
    imports = [{ inherit flake; }] ++ (mkModules flake);
  });

  mkFlake = args: module: extendFlake {
    inherit args;

    module = {
      imports = [
        self.flakeModules.shard
        module
      ];
    };

    mkFinalArgs = flake: {
      specialArgs = {
        src = inputs.haumea.lib.load {
          src = flake.__shard.source;
          inputs = lib.filterAttrs
            (k: _: !(builtins.elem k [ "self" "super" "root" ]))
            flake.__shard.args;
        };
      };
    } // args;

    mkModules = flake: flake.__shard.modules;
  };
in
{ inherit extendFlake mkFlake; }
