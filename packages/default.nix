{ fpkgs, inputs, ... }:

inputs.utils.lib.eachDefaultSystem (system: {
  packages.dmx-server = fpkgs.callPackage ./dmx-server { };
  packages.gdlauncher = fpkgs.callPackage ./gdlauncher.nix { };
  packages.xwinwrap = fpkgs.callPackage ./xwinwrap.nix { };
})
