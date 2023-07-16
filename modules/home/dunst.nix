{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.dunst;
in
{
  options.base.dunst = {
    enable = mkEnableOption "Dunst";
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings.global.notification_limit = 3;
    };
  };
}
