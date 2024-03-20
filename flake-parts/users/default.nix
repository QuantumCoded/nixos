_: { config, lib, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;
in
{
  config.flake.userModules = {
    jeff = import ./jeff.nix;

    # default.imports = combineModules config.flake.homeModules;
  };
}
