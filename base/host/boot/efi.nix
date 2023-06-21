{ efiDir ? "/boot/efi" }:
{ ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = efiDir;
}
