{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

    "/boot/efi" = {
      device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };

    "/data" = {
      device = "/dev/disk/by-label/data";
      fsType = "ext4";
    };
  };
}
