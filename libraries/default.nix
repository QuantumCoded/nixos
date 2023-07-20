{ fpkgs, inputs, self }:

{
  buildFirefoxXpiAddon = fpkgs.callPackage ./build-firefox-xpi-addon.nix;
}
