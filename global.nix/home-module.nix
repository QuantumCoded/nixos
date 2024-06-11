{ lib, ... }:
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  options.global = mkOption {
    type = types.anything;
    default = { };
  };
}
