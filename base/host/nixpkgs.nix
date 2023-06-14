{ allowUnfree ? true, permittedInsecurePackages ? [ ] }:
{ lib, ... }:

{
  nixpkgs.config = { inherit allowUnfree permittedInsecurePackages; };
}
