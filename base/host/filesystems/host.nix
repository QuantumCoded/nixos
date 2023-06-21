{ efiDevice ? "/dev/disk/by-label/EFI"
, rootDevice ? "/dev/disk/by-label/root"
, swapDevice ? "/dev/disk/by-label/swap"
, rootFsType ? "ext4"
, enableEfi ? true
, enableRoot ? true
, enableSwap ? true
}:
{ lib, ... }:

{
  config = lib.mkMerge [
    (lib.mkIf enableRoot {
      fileSystems."/" = {
        device = rootDevice;
        fsType = rootFsType;
      };
    })

    (lib.mkIf enableEfi {
      fileSystems."/boot/efi" = {
        device = efiDevice;
        fsType = "vfat";
      };
    })

    (lib.mkIf enableSwap {
      swapDevices = [{ device = swapDevice; }];
    })
  ];
}
