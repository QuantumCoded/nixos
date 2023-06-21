{ driSupport ? true
, driSupport32 ? true
, package ? null
}:
{ lib, pkgs, ... }:

{
  # Enable OpenGL for kitty terminal.
  hardware.opengl = lib.mkMerge [
    {
      inherit driSupport driSupport32;
    }

    (lib.mkIf (package != null) { inherit package; })
  ];
}
