{ config, inputs, ... }:
let
  inherit (config.flake)
    hardwareModules
    hostModules
    ;
in
{
  machines.hydrogen = {
    hardware = hardwareModules.hydrogen;
    host = hostModules.hydrogen;
    users.jeff = { };
    roles = [ "server" "syncthing-peer" ];
    extraNixos.imports = [
      inputs.agenix.nixosModules.default
      inputs.attic.nixosModules.atticd
      {
        base.wireguard.enable = true;
        age.secrets.luninet-hydrogen = {
          file = ../../../../secrets/luninet-hydrogen.age;
          mode = "0400";
        };
      }
    ];
    extraHomeManager.imports = [
      { base.git.enable = true; }
    ];
    stateVersion = "24.05";
  };
}
