{ config, lib, ... }:
let
  inherit (lib)
    mkOption
    types
    ;

  inherit (config.flake.lib)
    combineModules
    ;

  modules = {
    builders = import ./builders.nix;
    home-config = import ./home-config.nix;
  };
in
{
  imports = lib.attrValues modules;

  options.flake.transposeModules = mkOption {
    type = with types; attrsOf deferredModule;
    default = { };
  };

  config.flake.transposeModules = modules // {
    default.imports = combineModules config.flake.transposeModules;
  };
}
