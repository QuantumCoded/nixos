{ config, flakeRoot, inputs, ... }:
let
  inherit (config.flake)
    hardwareModules
    hostModules
    userModules
    ;
in
{
  machines.quantum = {
    hardware = hardwareModules.quantum;
    host = hostModules.quantum;
    users.jeff = userModules.jeff;
    roles = [
      "desktop"
      "podman"
      "syncthing-peer"
      "virtualization"
      "workstation"
    ];
    extraNixos.imports = [
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.default
      {
        base.wireguard.enable = true;
        age.secrets.luninet-quantum = {
          file = flakeRoot + "/secrets/luninet-quantum.age";
          mode = "0400";
        };
      }
    ];
    stateVersion = "24.05";
  };
}
