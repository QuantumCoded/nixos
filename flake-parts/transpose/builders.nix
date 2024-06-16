_: { config, flake-parts-lib, inputs, lib, ... }:
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
  file = ./builders.nix;
  name = "builders";
  option = mkOption {
    type = with types; attrsOf raw;
    default = { };
  };
}
