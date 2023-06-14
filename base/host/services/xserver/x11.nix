{ kbLayout ? "us", xkbVariant ? "" }:
{ ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    inherit xkbVariant;
    layout = kbLayout;
  };
}
