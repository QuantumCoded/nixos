{ nixpkgs, ... }:

{
  buildFirefoxXpiAddon = nixpkgs.callPackage ./build-firefox-xpi-addon.nix;
  nvencUnlock = import ./nvenc-unlock.nix;
  nvfbcUnlock = import ./nvfbc-unlock.nix;
}
