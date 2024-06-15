{ config, ... }:
let
  inherit (config.flake.lib)
    combineModules
    ;
in
{
  flake.nixosModules = {
    deemix-server = import ./modules/services/deemix-server.nix;
    kiwix = import ./modules/services/kiwix.nix;
    minecraft = import ./modules/services/minecraft.nix;

    input = import ./modules/input;
    boot = import ./modules/boot.nix;
    flakes = import ./modules/flakes.nix;
    networkmanager = import ./modules/networkmanager.nix;
    nvidia = import ./modules/nvidia.nix;
    virtualization = import ./modules/virtualization.nix;
    default.imports = combineModules config.flake.nixosModules;
  };
}
