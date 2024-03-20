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
  file = ./nixos-config.nix;
  name = "nixosConfiguration";
  option = mkOption {
    type = options.machines.type;
    default = { };
  };
}
