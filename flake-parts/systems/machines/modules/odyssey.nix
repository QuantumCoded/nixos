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
    users.jeff = userModules.jeff;
    roles = with roleModules; [ laptop workstation ];
    extraNixos.imports = [
      inputs.agenix.nixosModules.default
    ];
    stateVersion = "24.05";
  };
}
