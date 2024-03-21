_: { flake-parts-lib, lib, options, ... }:
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
  name = "nixosConfiguration";
  option = mkOption {
    type = options.machines.type;
    default = { };
  };
}
