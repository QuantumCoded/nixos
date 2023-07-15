{ inputs, pkgs, self, ... }:

{
  imports = [
    ../modules/boot.nix
    ../modules/flakes.nix
    ../modules/networkmanager.nix
    ../modules/overlays.nix

    inputs.home-manager.nixosModules.home-manager
  ];

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

  base.networkmanager.enable = true;
  base.networkmanager.connections = {
    wifi_5g = ../secrets/wifi_5g.age;
    wifi = ../secrets/wifi.age;
  };

  services.openssh.enable = true;

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;

  users.users.jeff = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];

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
      # neofetch
      nix-index # TODO: see if nix-index can be ran automatically
      noisetorch
      raccoon.kitty # TODO: see if there is an update that fixed this yet
      sonixd
      wireguard-tools

      # gaming
      steam
      # TODO: gdlauncher

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
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  system.stateVersion = "23.05";

  # TODO: all of this needs to be moved to somewhere else that defines users
  home-manager.extraSpecialArgs = { inherit inputs self; };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."jeff" = {
    imports = [
      ../home/fish
      ../home/neofetch
      ../home/dunst.nix
      ../home/kitty.nix
      ../home/rofi.nix
      ../home/sxhkd.nix
    ];

    home = rec {
      username = "jeff";
      homeDirectory = "/home/${username}";
      stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
    xsession.windowManager.bspwm.enable = true;

    base.sxhkd.enable = true;
    base.sxhkd.desktopOrder = "1,4,7,2,5,8,3,6,9,10";
  };
}