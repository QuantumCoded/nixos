{}:
{ ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-label/efi";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
