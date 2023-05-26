{ pkgs, ... }:
{
  xsession.windowManager.bspwm = {
    enable = true;

    # TODO: This needs to be updated to handle multiple machines
    monitors = {
      eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
    };

    # Stylix does this step in `xsession.initExtra`, but that will run any time X11 loads.
    # Using xsession.windowManager.bspwm.extraConfig prevents the wallpaper from being set in plasma.
    extraConfig = ''
      ${pkgs.feh}/bin/feh  --no-fehbg --bg-scale ${../wallpaper.jpg}
    '';
  };
}
