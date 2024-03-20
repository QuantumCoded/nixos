{
  homeManager = { pkgs, ... }:
    let
      internalMonitor = "eDP-1";
      externalMonitor = "HDMI-1";
    in
    {
      xsession.windowManager.bspwm.extraConfig = ''
        if [[ "$1" = 0 ]]; then
          if [[ $(xrandr -q | grep "${externalMonitor} connected") ]]; then
            bspc monitor "${externalMonitor}" -d 1 2 3 4 5
            bspc monitor "${internalMonitor}" -d 6 7 8 9 10
            bspc wm -O "${externalMonitor}" "${internalMonitor}"
            xrandr --output HDMI-1 --auto --left-of eDP-1
          else
            bspc monitor "${internalMonitor}" -d 1 2 3 4 5 6 7 8 9 10
          fi
        fi

        ${pkgs.feh}/bin/feh --bg-max ${../../../wallpapers/wallpaper.jpg}
      '';
    };

  nixos = {
    networking.hostName = "odyssey";
    hardware.bluetooth.enable = true;
  };
}
