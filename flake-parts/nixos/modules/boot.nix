{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.boot;
in
{
  options.base.boot = {
    enable = mkEnableOption "Boot";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
