{ config, ... }:
let
  overlaysModule = { inputs, pkgs, ... }:
    let
      inherit (pkgs) system;

      overlay-tapir = _: _: {
        tapir = import inputs.nixpkgs-tapir {
          inherit system;
          config.allowUnfree = true;
        };
      };

      overlay-unstable = _: _: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };

      overlay-self = _: _: {
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
