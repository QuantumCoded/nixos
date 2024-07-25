{ config, lib, ... }:
let
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

  flake.transpose = modules // {
    default.imports = combineModules config.flake.transpose;
  };
}
