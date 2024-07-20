{ config, ... }:
let
  overlaysModule = { inputs, pkgs, ... }:
    let
      system = pkgs.system;

      overlay-tapir = final: prev: {
        tapir = import inputs.nixpkgs-tapir {
          inherit system;
          config.allowUnfree = true;
        };
      };

      overlay-unstable = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };

      overlay-self = final: prev: {
        self = config.flake.packages.${system};
      };
    in
    {
      nixpkgs.overlays = [
        inputs.nur.overlay
        overlay-tapir
        overlay-unstable
        overlay-self
      ];
    };
in
{
  flake = {
    homeModules.overlays = overlaysModule;
    nixosModules.overlays = overlaysModule;
  };
}
