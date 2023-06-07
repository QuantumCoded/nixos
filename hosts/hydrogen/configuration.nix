# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, inputs, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Define your hostname.
  networking.hostName = "hydrogen";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    curl
    fish
    git
    man-pages
    man-pages-posix
    micro
    tmux
    vim
    wget
  ];

  # Set the root shell to fish.
  users.users.root.shell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jeff = {
    isNormalUser = true;
    description = "Jeff";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

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

  # Enable Nix flake packages.
  nix.package = pkgs.nixFlakes;

  # Experimental features.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable nixpkgs in nix repl.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.registry.raccoon.flake = inputs.nixpkgs-raccoon;
  nix.registry.unstable.flake = inputs.nixpkgs-unstable;

  # Use the latest compatible kernel for ZFS.
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  # Disable hibernation because ZFS does not support swapfiles.
  boot.kernelParams = [ "nohibernate" ];

  # Enable ZFS as a file system for the machine.
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "e79f9abc";

  
}
