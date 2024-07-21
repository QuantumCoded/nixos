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
    denoising = import ./modules/denoising.nix;
    syncthing = import ./modules/syncthing.nix;
    virtualization = import ./modules/virtualization.nix;
    default.imports = combineModules config.flake.nixosModules;
  };
}
