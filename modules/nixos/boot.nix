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
    boot.loader.systemd-boot.enable = true;

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
  };
}
