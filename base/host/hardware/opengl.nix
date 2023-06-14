{ package ? null }:
{ lib, pkgs, ... }:

{
  # Enable OpenGL for kitty terminal.
  hardware.opengl = lib.mkMerge [
    {
      driSupport = true;
      driSupport32Bit = true;
    }

    (lib.mkIf (package != null) { inherit package; })
  ];
}