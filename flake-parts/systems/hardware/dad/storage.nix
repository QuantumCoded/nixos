{ inputs, ... }: {
  fileSystems = {
    "/nfs/hydrogen" = {
      device = "hydrogen.lan:/data";
      fsType = "nfs";
      options = [
        "x-systemd.automount"
        "noauto"
        "x-systemd.idle-timeout=600"
      ];
    };

    "/run/media/${inputs.homelab.userNames.dad}/Scratch" = {
      device = "/dev/disk/by-label/Scratch";
      fsType = "ntfs";
    };
  };
}
