# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:
{
  imports =
    [
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
}
