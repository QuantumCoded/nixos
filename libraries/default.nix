{ fpkgs, inputs, self } @ libSpecialArgs:

{
  buildFirefoxXpiAddon = import ./build-firefox-xpi-addon.nix libSpecialArgs;
  calculateIncluded = import ./calculate-included.nix libSpecialArgs;
  capitalizeFirst = import ./capitalize-first.nix libSpecialArgs;
  configureDisplays = import ./configure-displays.nix libSpecialArgs;
  enumerate = import ./enumerate.nix libSpecialArgs;
  readDirFiltered = import ./read-dir-filtered.nix libSpecialArgs;
}
