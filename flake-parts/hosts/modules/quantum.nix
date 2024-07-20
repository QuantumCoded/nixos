{
  homeManager = { pkgs, self, ... }: {
    xsession.windowManager.bspwm = {
      monitors = {
        DP-0 = [ "L1" "L2" "L3" ];
        DP-2 = [ "M1" "M2" "M3" ];
        DP-4 = [ "R1" "R2" "R3" ];
        HDMI-0 = [ "P" ];
      };

      extraConfig = ''
        ${pkgs.procps}/bin/pidof xwinwrap \
        || ${pkgs.self.xwinwrap}/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 \
        -- ${pkgs.mpv}/bin/mpv -wid WID --loop --no-audio --no-terminal \
        ${../../../wallpapers/animated.mkv}
      '';
    };

    base = {
      dunst = {
        origin = "bottom-left";
        monitor = 1;
      };

      sxhkd.desktopOrder = "1,4,7,2,5,8,3,6,9,10";
    };
  };

  nixos = { pkgs, ... }: {
    networking = {
      hostName = "quantum";
      # FIXME: change this to eth intherface
      interfaces.wlp3s0.wakeOnLan.enable = true;
    };

    # TODO: this should adapt to different monitor configurations
    # specifically 1, 3, and 4 monitor(s)
    services.xserver.displayManager.setupCommands =
      let
        brightness = "1";
      in
      ''
        ${pkgs.xorg.xrandr}/bin/xrandr \
        --output DP-0 --mode 1920x1080 --rate 144 --pos 0x0 --brightness ${brightness} \
        --output DP-2 --primary --mode 1920x1080 --rate 144 --right-of DP-0 --brightness ${brightness} \
        --output DP-4 --mode 1920x1080 --rate 144 --right-of DP-2 --brightness ${brightness} \
        --output HDMI-0 --mode 1920x1080 --rate 60 --right-of DP-4 --brightness 1
      '';

    base.nvidia = {
      enable = true;
      patchNvenc = true;
      patchNvfbc = true;
    };

    hardware.bluetooth.enable = true;
    nix.settings.trusted-users = [ "jeff" ];
  };
}
