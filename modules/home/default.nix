{ lib, self, ... }:

{
  imports = lib.pipe { path = ./.; exclude = [ "default.nix" ]; } [
    self.lib.readDirFiltered
    (map (name: ./. + "/${name}"))
  ];
}
