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

  # HACK: this needs to be removed when moving to the server
  base.networkmanager.enable = true;
  base.networkmanager.connections = {
    wifi_5g = ../secrets/wifi_5g.age;
    wifi = ../secrets/wifi.age;
  };

  base.user.jeff.enable = true;

  networking.firewall = {
    allowedTCPPorts = [
      # 20 21
      80
      443
    ];
    # connectionTrackingModules = [ "ftp" ];
  };

  services = {
    airsonic = {
      enable = true;
      jre = pkgs.openjdk11;
      maxMemory = 2048;
      war = "${pkgs.flake.airsonic-advanced.outPath}/webapps/airsonic.war";
    };

    ankisyncd.enable = true;

    caddy = {
      enable = true;
      virtualHosts = {
        "http://airsonic.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:4040";
        "http://ankisync.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:27701";
        "http://deemix.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:6595";
        "http://gitea.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:3001";
        "http://invidious.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:3000";
        "http://jellyfin.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:8096";
        "http://searx.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:8888";
        "http://syncthing.hydrogen.lan".extraConfig = "reverse_proxy http://127.0.0.1:8384";
      };
    };

    gitea = {
      enable = true;
      appName = "QuantumCoded Gitea Server";
      settings.server = {
        ROOT_URL = "http://gitea.hydrogen.lan/";
        DOMAIN = "gitea.hydrogen.lan";
        HTTP_PORT = 3001;
      };
    };

    invidious = {
      enable = true;
      domain = "invidious.hydrogen.lan";
    };

    jellyfin.enable = true;
    openssh.enable = true;

    searx = {
      enable = true;
      package = pkgs.searxng;
      # https://github.com/searx/searx/blob/master/searx/settings.yml
      settings = {
        server = {
          base_url = "http://searx.hydrogen.lan/";
          # HACK: searx won't start without this being set
          # a secure key should be used and encrypted, but i think that requires encrypting the yml
          secret_key = "ca612e3566fdfd7cf7efe2b1c9349f461158d07cb78a3750e5c5be686aa8ebdc";
        };
      };
    };

    syncthing = {
      enable = true;
      # TODO: add devices
    };

    vsftpd = {
      # enable = true;
      localUsers = true;
      userlist = [ "sender" ];
      writeEnable = true;
      # set the passive ports range here and in firewall
      # add a symlink in systemd tmpfiles
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /var/lib/airsonic - airsonic airsonic - /data/services/airsonic"
    "L+ /var/lib/ankisyncd - - - - /data/services/ankisyncd"
    "L+ /var/lib/caddy - caddy caddy - /data/services/caddy"
    "L+ /var/lib/dmx - dmx dmx - /data/services/deemix"
    "L+ /var/lib/gitea - gitea gitea - /data/services/gitea"
    "L+ /var/lib/jellyfin - jellyfin jellyfin - /data/services/jellyfin"
    "L+ /var/lib/minecraft - minecraft minecraft - /data/services/minecraft"
    # TODO: redis for searx
    # TODO: postgres for invidious and friends
    # TODO: symlink music dir into place
  ];

  base.dmx-server.enable = true;

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
  };

  base.homeBaseConfig.git.enable = true;

  system.stateVersion = "23.05";
}
