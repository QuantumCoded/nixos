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
    flatpak.enable = true;
    pcscd.enable = true;
    openssh.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";

      windowManager.bspwm.enable = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
      ];
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  fonts.packages = with pkgs; [
    liberation_ttf
    nerdfonts
    self.nimbus-roman-ttf
  ];

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;

  virtualisation.docker.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  users.users.jeff = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "syncthing" ];
    shell = pkgs.fish;

    # TODO: packages could be split into different roles, not sure to get the username
    # to carry across roles though, perhaps that should be defined in the system somehow?
    packages = with pkgs; [
      comma
      distrobox
      emacs
      feh
      file
      flameshot
      man-pages
      man-pages-posix
      neofetch
      nix-index # TODO: see if nix-index can be ran automatically
      sonixd
      wireguard-tools
      keepassxc

      # gaming
      dwarf-fortress
      steam
      prismlauncher
      unstable.minetest

      # development
      nil
      nixpkgs-fmt
      self.imhex

      # productivity
      anki
      libreoffice
      obsidian
      thunderbird

      # social
      element-desktop
      unstable.vesktop
    ];
  };

  programs = {
    direnv.enable = true;
    steam.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

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


  time.timeZone = "America/Chicago";

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
