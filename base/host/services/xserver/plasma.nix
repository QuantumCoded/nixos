{ withSddm ? true }:
{ ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = withSddm;
  services.xserver.desktopManager.plasma5.enable = true;
}
