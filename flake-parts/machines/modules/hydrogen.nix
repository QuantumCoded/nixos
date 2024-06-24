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
  machines.hydrogen = {
    hardware = hardwareModules.hydrogen;
    host = hostModules.hydrogen;
    users.jeff = [ ];
    roles = with roleModules; [ server ];
    extraNixos.imports = [
      ./overlays.nix
      inputs.agenix.nixosModules.default
      inputs.attic.nixosModules.atticd
      {
        base.wireguard.enable = true;
        age.secrets.luninet-hydrogen = {
          file = ./secrets/luninet-hydrogen.age;
          mode = "0400";
        };
      }
    ];
    extraHomeManager.imports = [
      { base.git.enable = true; }
      ./overlays.nix
    ];
    stateVersion = "24.05";
  };
}
