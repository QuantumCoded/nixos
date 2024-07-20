{ config, ... }:
let
  inherit (config.flake.lib) combineModules;

  modules = {
    avalon = ./modules/avalon.nix;
    hydrogen = ./modules/hydrogen.nix;
    odyssey = ./modules/odyssey.nix;
    quantum = ./modules/quantum.nix;
  };
in
{
  imports =
    [ ./flake-module.nix ]
    ++ builtins.attrValues modules;

  flake.machineModules = modules // {
    default.imports = combineModules config.flake.machineModules;
  };
}
