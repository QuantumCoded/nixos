{ config, pkgs, system, nixpkgs, nixpkgs-unstable, ... }:
  let
    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixpkgs.overlays = [ overlay-unstable ];
  }