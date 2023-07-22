{ lib, pkgs, ... }:
let
  inherit (lib) concatStringsSep;
in
{
  hardware.opengl = {
    # TODO: might need to downgrade for kitty if it's not fixed yet
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  security.wrappers.noisetorch = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_resource+ep";
    source = "${pkgs.noisetorch}/bin/noisetorch";
  };

  services.xserver = {
    enable = true;
    layout = "us";
  };

  services.xserver.windowManager.bspwm.enable = true;

  services.printing.enable = true;

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

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  services.openssh.enable = true;

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;

  users.users.jeff = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;

    # TODO: packages could be split into different roles, not sure to get the username
    # to carry across roles though, perhaps that should be defined in the system somehow?
    packages = with pkgs; [
      comma
      feh
      file
      flameshot
      man-pages
      man-pages-posix
      # mpv
      neofetch
      nix-index # TODO: see if nix-index can be ran automatically
      noisetorch
      raccoon.kitty # TODO: see if there is an update that fixed this yet
      sonixd
      wireguard-tools

      # gaming
      steam
      flake.gdlauncher

      # TODO: this goes in vscode
      nil
      nixpkgs-fmt

      # productivity
      anki
      libreoffice
      obsidian
      thunderbird

      # social
      element-desktop
      unstable.discord
    ];
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

  time.timeZone = "America/Chicago";

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

  nixpkgs.config = {
    allowUnfree = true;
  };

  base.boot.enable = true;
  base.flakes.enable = true;

  base.networkmanager.enable = true;
  base.networkmanager.connections = {
    wifi_5g = ../secrets/wifi_5g.age;
    wifi = ../secrets/wifi.age;
  };

  base.user.jeff.enable = true;
  base.user.jeff.baseConfig = {
    fish.tide.enable = true;
  };

  base.minecraft.enable = true;
  base.minecraft.servers.nomifactory = {
    port = 25565;
    preStart = '''';
    restart = false;
    jar = "forge-1.12.2-14.23.5.2860.jar";
    jre = pkgs.openjdk8;
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
  };

  base.direnv.enable = true;
  base.homeBaseConfig = {
    fish.funcs.ide.enable = true;
  };

  system.stateVersion = "23.05";
}
