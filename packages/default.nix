{ inputs, ... }:

inputs.utils.lib.eachDefaultSystem (system:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  packages.gdlauncher = pkgs.callPackage ./gdlauncher.nix { };
  packages.xwinwrap = pkgs.callPackage ./xwinwrap.nix { };
})
