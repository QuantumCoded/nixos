{ config, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;
in
{
  flake.nixosModules = {
    input = import ./modules/input;
    boot = import ./modules/boot.nix;
    flakes = import ./modules/flakes.nix;
    networkmanager = import ./modules/networkmanager.nix;
    nvidia = import ./modules/nvidia.nix;
    virtualization = import ./modules/virtualization.nix;
    default.imports = combineModules config.flake.nixosModules;
  };
}
