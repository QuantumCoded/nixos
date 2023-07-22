{ lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep;
in
{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  services.openssh.enable = true;

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;

  users.users.jeff = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;

    packages = [ ];
  };

  environment.systemPackages = with pkgs; [
    btop
    git
    micro
    tmux
    tree
    vim
    wget
    xclip
  ];

  i18n = rec {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_NAME = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_TIME = defaultLocale;
    };
  };

  nixpkgs.config.allowUnfree = true;

  base.boot.enable = true;
  base.flakes.enable = true;

  # FIXME: this needs to be removed when moving to the server
  base.networkmanager.enable = true;
  base.networkmanager.connections = {
    wifi_5g = ../secrets/wifi_5g.age;
    wifi = ../secrets/wifi.age;
  };

  base.user.jeff.enable = true;

  base.minecraft.enable = true;
  base.minecraft.servers =
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
      # nomifactory = {
      #   inherit jvmOpts;
      #   port = 25566;
      #   preStart = '''';
      #   restart = false;
      #   jar = "forge-1.12.2-14.23.5.2860.jar";
      #   jre = pkgs.openjdk8;
      # };

      vanilla = {
        inherit jvmOpts;
        port = 25565;
        restart = false;
        jar = "paperclip.jar";
      };
    };

  base.dmx-server.enable = true;

  services.vsftpd = {
    enable = true;
    localUsers = true;
    userlist = [ "sender" ];
    writeEnable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [ 20 21 ];
    connectionTrackingModules = [ "ftp" ];
  };

  # ankisyncd
  # gitea
  # invidious
  # jellyfin
  # searx
  # syncthing

  system.stateVersion = "23.05";
}
