{ config, lib, options, ... }:
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  options = {
    secrets = mkOption {
      type = with types; attrsOf path;
      default = { };
    };
  };

  config = {
    secrets = {
    };

    flake.nixosModules.secrets = {
      example = {
      };
    };
  };
}
