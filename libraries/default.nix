{ fpkgs, inputs, self } @ libSpecialArgs:

{
  buildFirefoxXpiAddon = import ./build-firefox-xpi-addon.nix libSpecialArgs;
  capitalizeFirst = import ./capitalize-first.nix libSpecialArgs;
  readDirFiltered = import ./read-dir-filtered.nix libSpecialArgs;
}
