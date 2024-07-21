{ flake-parts-lib, lib, options, ... }:
let
  inherit (lib)
    mkOption
    ;

  inherit (flake-parts-lib)
    mkTransposedPerSystemModule
    ;
in
mkTransposedPerSystemModule {
  file = ./machines.nix;
  name = "machines";
  option = mkOption {
    inherit (options.machines) type;
    default = { };
  };
}
