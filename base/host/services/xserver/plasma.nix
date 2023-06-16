{ withSddm ? true }:
{ lib, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager = lib.mkIf withSddm {
    sddm = {
      enable = true;
      autoNumlock = true;
    };
  };
}
