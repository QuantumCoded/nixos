args @ { pkgs, ... }:

{
  imports = [
    # FIXME: this name clashes, maybe flake was a better namespace?
    args.self.serviceModules.syncthing
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  fileSystems."/nfs/hydrogen" = {
    device = "hydrogen.lan:/data";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };

  services = {
    openssh.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
      ];
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  virtualisation.podman.enable = true;

  environment.systemPackages = with pkgs; [
    btop
    git
    lazygit
    libqalculate
    micro
    ntfs3g
    sshpass
    tmux
    tree
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

  base = {
    boot.enable = true;
    flakes.enable = true;
    input.enable = true;
    pipewire.enable = true;

    networkmanager = {
      enable = true;
      connections = {
        wifi_5g = ../../../secrets/wifi_5g.age;
        wifi = ../../../secrets/wifi.age;
      };
    };
  };
}
