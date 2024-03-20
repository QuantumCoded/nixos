{ pkgs, ... }:

{
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

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

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplip
    ];
  };

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

  fonts.packages = with pkgs; [
    liberation_ttf
    nerdfonts
    flake.nimbus-roman-ttf
  ];

  services.openssh.enable = true;

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;

  virtualisation.docker.enable = true;

  users.users.jeff = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.fish;

    # TODO: packages could be split into different roles, not sure to get the username
    # to carry across roles though, perhaps that should be defined in the system somehow?
    packages = with pkgs; [
      comma
      distrobox
      feh
      file
      flameshot
      man-pages
      man-pages-posix
      neofetch
      nix-index # TODO: see if nix-index can be ran automatically
      noisetorch
      sonixd
      wireguard-tools

      # gaming
      dwarf-fortress
      steam
      prismlauncher

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
      vesktop
    ];
  };

  programs.direnv.enable = true;

  programs.steam.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.flatpak.enable = true;

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

    networkmanager = {
      enable = true;
      connections = {
        wifi_5g = ../../../secrets/wifi_5g.age;
        wifi = ../../../secrets/wifi.age;
      };
    };
  };
}
