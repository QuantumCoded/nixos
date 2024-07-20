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

    "/nfs/hydrogen" = {
      device = "hydrogen.lan:/data";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
