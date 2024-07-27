{
  homeManager = { flakeRoot, pkgs, ... }: {
    xsession.windowManager.bspwm.extraConfig = ''
      bspc monitor "eDP-1" -d 1 2 3 4 5 6 7 8 9 10

      ${pkgs.feh}/bin/feh --bg-max ${flakeRoot + "/wallpapers/wallpaper.jpg"}
    '';
  };

  nixos = { flakeRoot, inputs, pkgs, ... }: {
    networking.hostName = "avalon";
    hardware.bluetooth.enable = true;
    time.timeZone = "America/Chicago";

    services.xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080
    '';

    base.syncthing = {
      # enable = true;
      networks = inputs.homelab.syncthingNetworks;
    };

    age.secrets = {
      syncthing-avalon-cert = {
        file = flakeRoot + "/secrets/syncthing-avalon-cert.age";
        path = "/var/lib/syncthing/.config/syncthing/cert.pem";
        mode = "0400";
        owner = "syncthing";
        group = "syncthing";
      };

      syncthing-avalon-key = {
        file = flakeRoot + "/secrets/syncthing-avalon-key.age";
        path = "/var/lib/syncthing/.config/syncthing/key.pem";
        mode = "0400";
        owner = "syncthing";
        group = "syncthing";
      };
    };
  };
}
