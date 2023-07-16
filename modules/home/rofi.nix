{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.rofi;
in
{
  options.base.rofi = {
    enable = mkEnableOption "Rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      font = "FiraCode Nerd Font Mono 10";
    };
  };
}
