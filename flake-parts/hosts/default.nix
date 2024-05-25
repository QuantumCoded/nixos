_: { config, lib, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;
in
{
  config.flake.hostModules = {
    avalon = import ./modules/avalon.nix;
    hydrogen = import ./modules/hydrogen.nix;
    odyssey = import ./modules/odyssey.nix;
    quantum = import ./modules/quantum.nix;
    default.imports = combineModules config.flake.homeModules;
  };
}
