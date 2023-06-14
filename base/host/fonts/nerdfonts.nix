{}:
{ pkgs, ... }:

{
  # Load patched nerdfonts.
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; })
  ];
}
