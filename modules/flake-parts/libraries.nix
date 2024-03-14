_: { config, inputs, self, ... }:
let
  # FIXME: use pkgs from flake-parts somehow
  pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
in
{
  perSystem = { pkgs, ... }: {
    packages = {
    };
  };

  flake = rec {
    lib = {
      buildFirefoxXpiAddon = pkgs.callPackage ../../libraries/build-firefox-xpi-addon.nix;
      nvencUnlock = import ../../libraries/nvenc-unlock.nix;
      nvfbcUnlock = import ../../libraries/nvfbc-unlock.nix;

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

    libraries = lib;
  };
}
