{ pkgs, ... }:

{
  programs.vscode.userSettings = {
    # Change the font size.
    "editor.fontSize" = 14;
  };

  xsession.windowManager.bspwm = {
    enable = true;

    monitors.eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];

    # Stylix does this step in `xsession.initExtra`, but that will run any time X11 loads.
    # Using xsession.windowManager.bspwm.extraConfig prevents the wallpaper from being set in plasma.
    extraConfig = ''
      ${pkgs.feh}/bin/feh  --no-fehbg --bg-scale ${../../wallpapers/wallpaper.jpg}
    '';
  };

  services.sxhkd.keybindings = {
    # focus or send to the given desktop
    "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
  };
}
