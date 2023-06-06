{ pkgs, ... }:

{
  programs.vscode.userSettings = {
    # Change the font size.
    "editor.fontSize" = 15;
  };

  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      DP-0 = [ "L1" "L2" "L3" ];
      DP-2 = [ "M1" "M2" "M3" ];
      DP-4 = [ "R1" "R2" "R3" ];
      HDMI-0 = [ "P" ];
    };

    # Stylix does this step in `xsession.initExtra`, but that will run any time X11 loads.
    # Using xsession.windowManager.bspwm.extraConfig prevents the wallpaper from being set in plasma.
    extraConfig = ''
      ${pkgs.feh}/bin/feh --no-fehbg --bg-scale ${../../wallpapers/wallpaper.jpg}
    '';
  };

  services.sxhkd.keybindings = {
    # focus or send to the given desktop
    "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1,4,7,2,5,8,3,6,9,10}'";
  };
}
