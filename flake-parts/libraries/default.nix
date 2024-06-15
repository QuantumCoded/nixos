args @ { config, lib, ... }:
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  options.flake.lib = mkOption {
    type = with types; attrsOf (functionTo anything);
    default = { };
  };

  config.flake = {
    lib.combineModules = import ./combine-modules.nix args;
    libraries = config.flake.lib;
  };
}
