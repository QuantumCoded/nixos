_: { config, lib, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;
in
{
  config.flake.roleModules = {
    desktop = import ./modules/desktop.nix;
    laptop = import ./modules/laptop.nix;
    server = import ./modules/server.nix;
    workstation = import ./modules/workstation.nix;
    default.imports = combineModules config.flake.homeModules;
  };
}
