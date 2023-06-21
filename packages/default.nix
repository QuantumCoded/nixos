{ fpkgs, inputs, ... }:

inputs.utils.lib.eachDefaultSystem (system:

{
  packages.gdlauncher = fpkgs.callPackage ./gdlauncher.nix { };
  packages.xwinwrap = fpkgs.callPackage ./xwinwrap.nix { };
})
