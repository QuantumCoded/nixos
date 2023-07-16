{ inputs, pkgs, self, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

  overlay-raccoon = final: prev: {
    raccoon = import nixpkgs-raccoon {
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

  overlay-flake = final: prev: {
    flake = self.packages.${system};
  };
in
{
  nixpkgs.overlays = [
    nur.overlay
    overlay-raccoon
    overlay-unstable
    overlay-flake
  ];
}
