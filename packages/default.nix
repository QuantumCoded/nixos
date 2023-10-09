{ nixpkgs, inputs, ... }:
let
  systems = [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ];
in
{
  packages = nixpkgs.lib.genAttrs systems (system: {
    airsonic-advanced = nixpkgs.callPackage ./airsonic-advanced.nix { };
    deemix-server = nixpkgs.callPackage ./deemix-server { };
    gdlauncher = nixpkgs.callPackage ./gdlauncher.nix { };
    nomos-rebuild = nixpkgs.callPackage ./nomos-rebuild { };
    tetrust = nixpkgs.callPackage ./tetrust.nix { };
    xwinwrap = nixpkgs.callPackage ./xwinwrap.nix { };

    # Re-export correct version of disko
    disko = inputs.disko.packages.${system}.disko;
  });
}
