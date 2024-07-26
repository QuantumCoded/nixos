{
  disko.devices = {
    disk = {
      maindisk = {
        device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_1TB_S467NX0M821177L";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "32G";
              content = {
                type = "swap";
                resumeDevice = true; # resume from hiberation from this device
              };
            };
            root = {
              label = "Linux";
              size = "250G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            home = {
              label = "Home";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };
          };
        };
      };
    };
  };
}
