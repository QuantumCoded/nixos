{ nixpkgs, inputs, ... }:

inputs.flake-utils.lib.eachDefaultSystem (system: {
  packages.airsonic-advanced = nixpkgs.callPackage ./airsonic-advanced.nix { };
  packages.deemix-server = nixpkgs.callPackage ./deemix-server { };
  packages.gdlauncher = nixpkgs.callPackage ./gdlauncher.nix { };
  packages.nomos-rebuild = nixpkgs.callPackage ./nomos-rebuild { };
  packages.xwinwrap = nixpkgs.callPackage ./xwinwrap.nix { };

  # Re-export correct version of disko
  packages.disko = inputs.disko.packages.${system}.disko;
})
