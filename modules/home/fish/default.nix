{ config, lib, ... }:
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
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      # TODO: tide and its configs need to be set as an option
      # plugins = [];
    };
  };
}
