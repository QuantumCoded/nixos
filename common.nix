# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  # Enable OpenGL for kitty terminal.
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

  # Get wireless network information from agenix.
  age.secrets = {
    wifi_5g = {
      file = ./secrets/wifi_5g.age;
      path = "/etc/NetworkManager/system-connections/Home_5G.nmconnection";
      mode = "400";
      owner = "root";
      group = "root";
    };

    wifi = {
      file = ./secrets/wifi.age;
      path = "/etc/NetworkManager/system-connections/Home.nmconnection";
      mode = "400";
      owner = "root";
      group = "root";
    };
  };

  # Enable Hydrogen NFS share
  fileSystems."/nfs/hydrogen" = {
    device = "docker.vmlan:/data";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };

  # Enable insecure electron for vscodium
  nixpkgs.config.permittedInsecurePackages = [
    "electron-21.4.0"
  ];

  # Enable Nix flake packages.
  nix.package = pkgs.nixFlakes;

  # Experimental features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable the BSPWM window manager.
  services.xserver.windowManager.bspwm.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Custom fonts.
  fonts.fonts = with pkgs; [
    # Use FiraCode from nerdfonts.
    (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; })
  ];

  # Enable fish shell.
  programs.fish.enable = true;

  # Define the shells for user accounts.
  environment.shells = with pkgs; [ fish ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeff = {
    isNormalUser = true;
    description = "Jeff";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      anki
      # ankisyncd - for server
      btop
      feh
      file
      flameshot
      font-manager
      # gdlauncher
      home-manager
      kate
      libreoffice
      man-pages
      man-pages-posix
      mpv
      neofetch
      nfs-utils
      nil
      nixpkgs-fmt
      nodejs
      obsidian
      pavucontrol
      python3
      rustup
      sonixd
      steam
      thunderbird
      tree
      unstable.discord
      vlc
      vulnix
      wireguard-tools
      xclip
      xwinwrap
      zsh-powerlevel10k
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    micro
    tmux
    vim
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
