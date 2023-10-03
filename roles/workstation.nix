{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    package = pkgs.raccoon.mesa.drivers;
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
  services.xserver.windowManager.twm.enable = true;

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
    ];
  };

  services.gnome.gnome-keyring.enable = true;

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

  virtualisation.waydroid.enable = true;

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
      raccoon.kitty # HACK: newer versions of kitty have a bug rednering svgs
      sonixd
      wireguard-tools

      # gaming
      dwarf-fortress
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

  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
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
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  base = {
    boot.enable = true;
    direnv.enable = true;
    flakes.enable = true;
    nixvim.enable = true;

    networkmanager = {
      enable = true;
      connections = {
        wifi_5g = ../secrets/wifi_5g.age;
        wifi = ../secrets/wifi.age;
      };
    };

    # tuigreet.enable = true;

    user.jeff = {
      enable = true;
      baseConfig.fish.tide.enable = true;
    };
  };

  system.stateVersion = "23.05";
}
