{
  homeManager = { pkgs, ... }: {
    xsession.windowManager.bspwm.extraConfig = ''
      bspc monitor "eDP-1" -d 1 2 3 4 5 6 7 8 9 10

      ${pkgs.feh}/bin/feh --bg-max ${../../../wallpapers/wallpaper.jpg}
    '';
  };

  nixos = { pkgs, ... }: {
    networking.hostName = "avalon";
    hardware.bluetooth.enable = true;

    services.xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080
    '';
  };
}
