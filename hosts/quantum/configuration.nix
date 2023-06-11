# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Define your hostname.
  networking.hostName = "quantum";

  # Enable Nvidia drivers.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Lazy mount external hard drive.
  fileSystems."/mnt" = {
    device = "/dev/disk/by-uuid/a819667b-aff9-4946-971b-4b0df6d31880";
    fsType = "ext4";
    options = [
      "x-systemd.automount"
      "noauto"
    ];
  };

  # Configure the displays.
  # TODO: refactor to look better, splitting this with either \ or \\ DOES NOT WORK!
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144 --pos 0x0 --output DP-2 --primary --mode 1920x1080 --rate 144 --right-of DP-0 --output DP-4 --mode 1920x1080 --rate 144 --right-of DP-2 --output HDMI-0 --mode 1920x1080 --rate 60 --right-of DP-4
  '';

  # Add gdlauncher to jeff's packages on quantum.
  users.users.jeff.packages = [
    (pkgs.callPackage ../../packages/gdlauncher.nix { })
  ];
}
