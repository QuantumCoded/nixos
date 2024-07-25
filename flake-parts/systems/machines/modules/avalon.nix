{ config, inputs, ... }:
let
  inherit (config.flake)
    hardwareModules
    hostModules
    userModules
    ;
in
{
  machines.avalon = {
    hardware = hardwareModules.avalon;
    host = hostModules.avalon;
    users.jeff = userModules.jeff;
    roles = [ "laptop" "workstation" ];
    extraNixos.imports = [
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.default
    ];
    stateVersion = "24.05";
  };
}
