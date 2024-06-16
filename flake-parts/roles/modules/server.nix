toplevel: { config, pkgs, ... }:

{
  imports = with toplevel.config.flake.serviceModules; [
    airsonic
    ankisyncd
    deemix
    kiwix
    minecraft

    ./services/atticd.nix
    ./services/caddy.nix
    ./services/forgejo.nix
    ./services/gonic.nix
    ./services/grafana.nix
    ./services/homepage.nix
    ./services/invidious.nix
    ./services/jellyfin.nix
    ./services/navidrome.nix
    ./services/nfs.nix
    ./services/pgadmin.nix
    ./services/postgresql.nix
    ./services/searx.nix
    ./services/syncthing.nix
    ./services/vikunja.nix
    ./services/vsftpd.nix
    ./services/woodpecker.nix
  ];

  fileSystems."/var/lib" = {
    options = [ "bind" ];
    device = "/data/services";
  };

  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   jack.enable = false;
  # };

  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;

  users.users.jeff = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "podman" ];
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

  systemd.services.NetworkManager-wait-online.enable = false;
  networking.networkmanager.enable = true;

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ];

    # UPnP for DLNA
    allowedUDPPorts = [ 1900 ];
  };

  services.openssh.enable = true;
}
