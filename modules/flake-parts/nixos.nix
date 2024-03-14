_: { config, lib, ... }: {
  flake.nixosModules =
    let
      modules = {
        ankisync = import ../nixos/services/ankisync.nix;
        deemix-server = import ../nixos/services/deemix-server.nix;
        minecraft = import ../nixos/services/minecraft.nix;

        input = import ../nixos/input;
        boot = import ../nixos/boot.nix;
        flakes = import ../nixos/flakes.nix;
        home-manager = import ../nixos/home-manager.nix;
        networkmanager = import ../nixos/networkmanager.nix;
        nvidia = import ../nixos/nvidia.nix;
        virtualization = import ../nixos/virtualization.nix;
      };

      default.imports = lib.mapAttrsToList (_: path: path) modules;
    in
      modules // { inherit default; };
}
