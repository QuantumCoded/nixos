_: { lib, ... }: {
  flake.nixosModules =
    let
      modules = {
        ankisync = import ./services/ankisync.nix;
        deemix-server = import ./services/deemix-server.nix;
        minecraft = import ./services/minecraft.nix;

        input = import ./input;
        boot = import ./boot.nix;
        flakes = import ./flakes.nix;
        home-manager = import ./home-manager.nix;
        networkmanager = import ./networkmanager.nix;
        nvidia = import ./nvidia.nix;
        virtualization = import ./virtualization.nix;
      };

      default.imports = lib.mapAttrsToList (_: mod: mod) modules;
    in
    modules // { inherit default; };

    flake.userModules =
      let
        modules = {
          jeff = {

          };
}

