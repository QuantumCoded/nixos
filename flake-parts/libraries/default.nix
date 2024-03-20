_: { config, inputs, lib, self, ... }:
let
  # FIXME: use pkgs from flake-parts somehow
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
in
{
  flake = {
    lib = {
      combineModules = import ./combine-modules.nix { inherit lib; };
      nvencUnlock = import ./nvenc-unlock.nix;
      nvfbcUnlock = import ./nvfbc-unlock.nix;

      mkHome = cfg: inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs self; };

        modules = [
          config.flake.homeModules.default
          ../../overlays.nix
          cfg
        ];
      };

      mkNixos = cfg: inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs self; };

        modules = [
          config.flake.nixosModules.default
          inputs.agenix.nixosModules.default
          inputs.disko.nixosModules.disko
          ../../common.nix
          ../../overlays.nix
          cfg
        ];
      };
    };

    libraries = config.flake.lib;
  };
}
