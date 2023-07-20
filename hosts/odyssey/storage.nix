{ ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
  };

  /*FIXME: enable this again later
    fileSystems."/nfs/hydrogen" = {
      device = "docker.vmlan:/data";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };
  */

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
