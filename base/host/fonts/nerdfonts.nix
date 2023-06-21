{ allFonts ? false, fonts ? [ ] }:
{ pkgs, ... }:

{
  # Load patched nerdfonts.
  fonts.fonts = with pkgs; [
    (if allFonts
    then nerdfonts
    else (nerdfonts.override { inherit fonts; }))
  ];
}
