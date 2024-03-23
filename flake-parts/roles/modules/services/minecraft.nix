{ lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep;
in
{
  base.minecraft = {
    enable = true;
    servers =
      let
        jvmOpts = concatStringsSep " " [
          "-server"
          "-Xms4G"
          "-Xmx8G"
          "-XX:+UseG1GC"
          "-XX:+ParallelRefProcEnabled"
          "-XX:MaxGCPauseMillis=200"
          "-XX:+UnlockExperimentalVMOptions"
          "-XX:+DisableExplicitGC"
          "-XX:+AlwaysPreTouch"
          "-XX:G1NewSizePercent=30"
          "-XX:G1MaxNewSizePercent=40"
          "-XX:G1HeapRegionSize=8M"
          "-XX:G1ReservePercent=20"
          "-XX:G1HeapWastePercent=5"
          "-XX:G1MixedGCCountTarget=4"
          "-XX:InitiatingHeapOccupancyPercent=15"
          "-XX:G1MixedGCLiveThresholdPercent=90"
          "-XX:G1RSetUpdatingPauseTimePercent=5"
          "-XX:SurvivorRatio=32"
          "-XX:+PerfDisableSharedMem"
          "-XX:MaxTenuringThreshold=1"
        ];
      in
      {
        nomifactory = {
          inherit jvmOpts;
          port = 25566;
          jar = "forge-1.12.2-14.23.5.2860.jar";
          jre = pkgs.openjdk8;
        };

        vanilla = {
          inherit jvmOpts;
          port = 25565;
          jar = "paperclip.jar";
        };
      };
    openPorts = true;
  };

  fileSystems."/var/lib/minecraft" = {
    device = "/data/services/minecraft";
    options = [ "bind" ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 19132 ];
    allowedUDPPorts = [ 19132 ];
  };
}
