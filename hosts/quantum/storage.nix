{
  # fileSystems."/" = {
  #   device = "/dev/disk/by-label/root";
  #   fsType = "ext4";
  # };

  # fileSystems."/boot/efi" = {
  #   device = "/dev/disk/by-label/EFI";
  #   fsType = "vfat";
  # };

  # fileSystems."/home" = {
  #   device = "/dev/disk/by-label/home";
  #   fsType = "ext4";
  # };

  # fileSystems."/nix" = {
  #   device = "/dev/disk/by-label/nix";
  #   fsType = "ext4";
  # };

  # fileSystems."/var" = {
  #   device = "/dev/disk/by-label/var";
  #   fsType = "ext4";
  # };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-label/storage";
    fsType = "ext4";
  };

  fileSystems."/nfs/hydrogen" = {
    device = "hydrogen.lan:/data";
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };

  # swapDevices = [
  #   { device = "/dev/disk/by-label/swap"; }
  # ];
}
