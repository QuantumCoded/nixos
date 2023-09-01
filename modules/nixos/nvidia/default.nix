{ config, lib, pkgs, ... }:
let
  inherit (lib)
    filter
    mkEnableOption
    mkIf
    mkOption
    pipe
    types
    zipLists
    ;

  patchNvenc = import ./nvenc-unlock.nix;
  patchNvfbc = import ./nvfbc-unlock.nix;

  cfg = config.base.nvidia;

  patchBools = [ cfg.patchNvenc cfg.patchNvfbc ];
  patchFuncs = [ patchNvenc patchNvfbc ];

  enabledPatches = map (zipped: zipped.snd)
    (filter
      (zipped: zipped.fst)
      (zipLists patchBools patchFuncs));

  patchDriver = driver: pipe driver enabledPatches;
in
{
  options.base.nvidia = {
    enable = mkEnableOption "Nvidia";

    patchNvenc = mkOption {
      type = types.bool;
      default = false;
    };

    patchNvfbc = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport32Bit = true;
      };

      nvidia = {
        package = patchDriver config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [ linuxPackages.nvidia_x11 ];
  };
}
