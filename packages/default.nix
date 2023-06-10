{ inputs, ... }:

inputs.utils.lib.eachDefaultSystem (system:
let
  pkgs = import inputs.nixpkgs { inherit system; };
in
{
  packages.gdlauncher = pkgs.callPackage ./gdlauncher.nix { };
})
