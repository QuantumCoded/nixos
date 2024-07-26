{ config, lib, ... }:
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  options.roles = mkOption {
    type = with types; attrsOf deferredModule;
    default = { };
  };

  config.flake = {
    roleModules = config.roles;

    nixosModules.roles = {
      options.roles = mkOption {
        type = with types; attrsOf bool;
        readOnly = true;
      };
    };

    homeModules.roles = {
      options.roles = mkOption {
        type = with types; attrsOf bool;
        readOnly = true;
      };
    };
  };
}
