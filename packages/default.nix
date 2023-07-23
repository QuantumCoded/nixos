{ nixpkgs, inputs, ... }:

inputs.flake-utils.lib.eachDefaultSystem (system: {
  packages.airsonic-advanced = nixpkgs.callPackage ./airsonic-advanced.nix { };
  packages.dmx-server = nixpkgs.callPackage ./dmx-server { };
  packages.gdlauncher = nixpkgs.callPackage ./gdlauncher.nix { };
  packages.xwinwrap = nixpkgs.callPackage ./xwinwrap.nix { };
})
