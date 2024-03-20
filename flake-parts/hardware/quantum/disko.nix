{
  disko.devices = {
    disk = {
      bootdisk = {
        type = "disk";
        device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_500GB_S598NE0M833873M";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
              };
            };
            swap = {
              size = "32G";
              content = {
                type = "swap";
                randomEncryption = true;
                resumeDevice = true; # resume from hiberation from this device
              };
            };
          };
        };
      };

      maindisk = {
        type = "disk";
        device = "/dev/disk/by-id/ata-ST6000VN0041-2EL11C_ZA1GHB1C";
        content = {
          type = "gpt";
          partitions = {
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted

                # FIXME: Remove compression from things that don't need it when disko is less jank
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/rootfs" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/";
                  };

                  # Parent is not mounted so the mountpoint must be set
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };

                  "/home" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/home";
                  };

                  "/var" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/var";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
