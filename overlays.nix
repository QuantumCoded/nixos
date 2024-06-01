{ inputs, pkgs, self, ... }:
with inputs;
let
  system = pkgs.stdenv.hostPlatform.system;

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
    vscode-extensions.overlays.default
    nur.overlay
    overlay-unstable
    overlay-flake
  ];
}
