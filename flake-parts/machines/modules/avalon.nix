{ config, inputs, ... }:
let
  inherit (config.flake)
    hardwareModules
    hostModules
    userModules
    roleModules
    ;
in
{
  machines.avalon = {
    hardware = hardwareModules.avalon;
    host = hostModules.avalon;
    users.jeff = with userModules; [ jeff ];
    roles = with roleModules; [ laptop workstation ];
    extraHomeManager.imports = [ ./overlays.nix ];
    extraNixos.imports = [
      ./overlays.nix
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.default
    ];
    stateVersion = "24.05";
  };
}
