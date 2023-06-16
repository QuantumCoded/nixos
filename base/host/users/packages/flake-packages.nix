{ include ? null
, exclude ? [ ]
, userName
}:
{ lib, pkgs, self, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  packages = self.packages.${system};
  included = self.lib.calculateIncluded {
    inherit exclude include;
    default = builtins.attrNames packages;
  };
in
{
  users.users.${userName}.packages = map (name: packages.${name}) included;
}
