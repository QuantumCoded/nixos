{ nixpkgs, inputs, ... }:

inputs.flake-utils.lib.eachDefaultSystem (system: {
  packages.dmx-server = nixpkgs.callPackage ./dmx-server.nix { };
  packages.gdlauncher = nixpkgs.callPackage ./gdlauncher.nix { };
  packages.xwinwrap = nixpkgs.callPackage ./xwinwrap.nix { };
})
