{ pkgs, ... }:

{
  fileSystems."/var/lib/airsonic" = {
    device = "/data/services/airsonic";
    options = [ "bind" ];
  };

  services = {
    airsonic = {
      enable = true;
      jre = pkgs.openjdk11;
      jvmOptions = [
        "-server"
        "-Xms4G"
        "-XX:+UseG1GC"
        "-XX:+ParallelRefProcEnabled"
        "-XX:MaxGCPauseMillis=200"
        "-XX:+UnlockExperimentalVMOptions"
        "-XX:+DisableExplicitGC"
        "-XX:+AlwaysPreTouch"
        "-XX:G1NewSizePercent=30"
        "-XX:G1MaxNewSizePercent=40"
        "-XX:G1HeapRegionSize=16M"
        "-XX:G1ReservePercent=20"
        "-XX:G1HeapWastePercent=5"
        "-XX:G1MixedGCCountTarget=4"
        "-XX:InitiatingHeapOccupancyPercent=25"
        "-XX:G1MixedGCLiveThresholdPercent=90"
        "-XX:G1RSetUpdatingPauseTimePercent=5"
        "-XX:SurvivorRatio=32"
        "-XX:+PerfDisableSharedMem"
        "-XX:MaxTenuringThreshold=1"
      ];
      maxMemory = 8192;
      war = "${pkgs.flake.airsonic-advanced}/webapps/airsonic.war";
    };

    caddy.virtualHosts."http://airsonic.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:4040
    '';

    postgresql = {
      ensureDatabases = [ "airsonic" ];
      authentication = ''
        local airsonic airsonic trust
        host airsonic airsonic 127.0.0.1/32 trust
      '';

      ensureUsers = [{
        name = "airsonic";
        ensureDBOwnership = true;
      }];
    };
  };
}
