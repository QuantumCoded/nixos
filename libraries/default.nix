{ nixpkgs, inputs, self } @ libSpecialArgs:

{
  buildFirefoxXpiAddon = nixpkgs.callPackage ./build-firefox-xpi-addon.nix;
  calculateIncluded = import ./calculate-included.nix libSpecialArgs;
  capitalizeFirst = import ./capitalize-first.nix libSpecialArgs;
  configureDisplays = import ./configure-displays.nix libSpecialArgs;
  enumerate = import ./enumerate.nix libSpecialArgs;
  readDirFiltered = import ./read-dir-filtered.nix libSpecialArgs;
}
