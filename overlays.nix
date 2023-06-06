{ pkgs, inputs, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

  overlay-racoon = final: prev: {
    racoon = import nixpkgs-racoon {
      inherit system;
      config.allowUnfree = true;
    };
  };

  overlay-unstable = final: prev: {
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{
  nixpkgs.overlays = [ nur.overlay overlay-racoon overlay-unstable ];
}
