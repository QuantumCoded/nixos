_: { flake-parts-lib, lib, ... }:
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
  file = ./home-config.nix;
  name = "homeConfiguration";
  option = mkOption {
    type = with types; attrsOf raw;
    default = { };
  };
}
