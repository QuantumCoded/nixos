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
  machines = {
    avalon = {
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

    hydrogen = {
      hardware = hardwareModules.hydrogen;
      host = hostModules.hydrogen;
      users.jeff = [ ];
      roles = with roleModules; [ server ];
      extraNixos.imports = [
        ./overlays.nix
        inputs.agenix.nixosModules.default
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

    odyssey = {
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

    quantum = {
      hardware = hardwareModules.quantum;
      host = hostModules.quantum;
      users.jeff = with userModules; [ jeff ];
      roles = with roleModules; [ desktop workstation ];
      extraHomeManager.imports = [ ./overlays.nix ];
      extraNixos.imports = [
        ./overlays.nix
        inputs.agenix.nixosModules.default
        inputs.disko.nixosModules.default
        {
          base.wireguard.enable = true;
          age.secrets.luninet-quantum = {
            file = ./secrets/luninet-quantum.age;
            mode = "0400";
          };
        }
      ];
      stateVersion = "24.05";
    };

    odyssey-server = {
      hardware = hardwareModules.odyssey;
      host = hostModules.hydrogen;
      users.jeff = with userModules; [ jeff ];
      roles = with roleModules; [ server ];
      extraHomeManager.imports = [ ./overlays.nix ];
      extraNixos.imports = [
        ./overlays.nix
        inputs.agenix.nixosModules.default
      ];
      stateVersion = "24.05";
    };
  };
}
