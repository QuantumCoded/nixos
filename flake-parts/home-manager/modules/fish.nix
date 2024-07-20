{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.fish;
in
{
  options.base.fish = {
    enable = mkEnableOption "Enable Fish";
    tide.enable = mkEnableOption "Fish Tide Theme";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      plugins = mkIf cfg.tide.enable [
        {
          name = "tide";
          inherit (pkgs.fishPlugins.tide) src;
        }
      ];
    };
  };
}
