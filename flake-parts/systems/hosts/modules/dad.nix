{
  homeManager = { };

  nixos = { inputs, pkgs, ... }: {
    base = {
      masterpdfeditor.enable = true;
      nvidia.enable = true;
      # TODO: rejoin the luninet
      # wireguard.enable = true;
    };

    networking.hostName = inputs.homelab.userNames.dad;

    services = {
      hardware.openrgb = {
        enable = true;
        motherboard = "intel";
      };

      xserver.displayManager.setupCommands = ''
        nvidia-settings -a AllowVRR=0
        ${pkgs.xorg.xrandr}/bin/xrandr \
        --output DP-0 --mode 2560x1440 --rate 180 --primary --pos 0x0 \
        --output DP-4 --mode 2560x1440 --rate 180 --right-of DP-0
      '';
    };

    time.timeZone = "America/Chicago";
  };
}
