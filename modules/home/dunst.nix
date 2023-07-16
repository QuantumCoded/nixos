{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.dunst;
in
{
  options.base.dunst = {
    enable = mkEnableOption "Dunst";
    monitor = mkOption {
      type = types.int;
      default = 0;
    };
    origin = mkOption {
      type = types.str;
      default = "top-right";
    };
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings.global = {
        inherit (cfg) monitor origin;
        notification_limit = 3;
      };
    };
  };
}
