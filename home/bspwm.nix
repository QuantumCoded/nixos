{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    ;

  cfg = config.base.bspwm;
in
{
  options.base.home.bspwm = {
    enable = mkEnableOption "BSPWM HomeManager";
    monitors = ""; # not sure where this shoud be getting set reeeeee
  };

  config = {

  };
}