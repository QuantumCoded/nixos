{ nixpkgs, inputs, ... }:

inputs.flake-utils.lib.eachDefaultSystem (system: {
  packages.gdlauncher = nixpkgs.callPackage ./gdlauncher.nix { };
  packages.xwinwrap = nixpkgs.callPackage ./xwinwrap.nix { };
})
