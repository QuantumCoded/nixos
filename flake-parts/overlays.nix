let
  overlaysModule = { inputs, pkgs, ... }:
  let
    system = pkgs.system;

    overlay-unstable = final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in
  {
    nixpkgs.overlays = [
      inputs.nur.overlay
      overlay-unstable
    ];
  };
in
{
  flake = {
    homeModules.overlays = overlaysModule;
    nixosModules.overlays = overlaysModule;
  };
}
