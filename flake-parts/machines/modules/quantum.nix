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
  machines.quantum = {
    hardware = hardwareModules.quantum;
    host = hostModules.quantum;
    users.jeff = with userModules; [ jeff ];
    roles = with roleModules; [ desktop workstation ];
    extraNixos.imports = [
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.default
      {
        base.wireguard.enable = true;
        age.secrets.luninet-quantum = {
          file = ../../../secrets/luninet-quantum.age;
          mode = "0400";
        };
      }
    ];
    stateVersion = "24.05";
  };
}
