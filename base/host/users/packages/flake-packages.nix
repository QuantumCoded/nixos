{ include ? null
, exclude ? [ ]
, userName
}:
{ lib, pkgs, self, ... }:
let
  included = self.lib.calculateIncluded {
    inherit exclude include;
    default = builtins.attrNames pkgs.flake;
  };
in
{
  users.users.${userName}.packages = map (name: pkgs.flake.${name}) included;
}
