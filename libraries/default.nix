{ nixpkgs, ... }:

{
  buildFirefoxXpiAddon = nixpkgs.callPackage ./build-firefox-xpi-addon.nix;
}
