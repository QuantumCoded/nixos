{ config, lib, pkgs, self, ... }:
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

  inherit (self.outputs.lib)
    nvencUnlock
    nvfbcUnlock
    ;

  cfg = config.base.nvidia;

  patchBools = with cfg; [ patchNvenc patchNvfbc ];
  patchFuncs = [ nvencUnlock nvfbcUnlock ];

  enabledPatches = pipe (zipLists patchBools patchFuncs) [
    (filter (zipped: zipped.fst))
    (map (zipped: zipped.snd))
  ];

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
