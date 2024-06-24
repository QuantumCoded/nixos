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
  machines.odyssey = {
    hardware = hardwareModules.odyssey;
    host = hostModules.odyssey;
    users.jeff = with userModules; [ jeff ];
    roles = with roleModules; [ laptop workstation ];
    extraHomeManager.imports = [ ./overlays.nix ];
    extraNixos.imports = [
      ./overlays.nix
      inputs.agenix.nixosModules.default
    ];
    stateVersion = "24.05";
  };
}
