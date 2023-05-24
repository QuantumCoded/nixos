{ config, pkgs, system, nixpkgs, nixpkgs-unstable, nur, ... }:
  let
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixpkgs.overlays = [ nur.overlay overlay-unstable ];
  }