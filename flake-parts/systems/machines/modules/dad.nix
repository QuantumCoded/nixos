{ config, inputs, ... }:
let
  inherit (config.flake)
    hardwareModules
    hostModules
    userModules
    ;
in
{
  machines.dad = {
    hardware = hardwareModules.dad;
    host = hostModules.dad;
    users.dad = userModules.dad;
    userNames.dad = inputs.homelab.userNames.dad;
    roles = [
      "desktop"
      "workstation"
      "podman"
    ];
    extraNixos.imports = [
      inputs.agenix.nixosModules.default
      inputs.disko.nixosModules.default
    ];
    stateVersion = "24.05";
  };
}
