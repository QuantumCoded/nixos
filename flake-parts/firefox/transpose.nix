{ flake-parts-lib, lib, ... }:
let
  inherit (lib)
    mkOption
    types
    ;

  inherit (flake-parts-lib)
    mkTransposedPerSystemModule
    ;
in
mkTransposedPerSystemModule {
  file = ./transpose.nix;
  name = "firefoxAddons";
  option = mkOption {
    type = with types; attrsOf package;
    default = { };
  };
}
