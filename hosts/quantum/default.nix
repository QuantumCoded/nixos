{ pkgs, ... }:

{
  imports = [
    ../../roles/desktop.nix
    ../../roles/workstation.nix

    ./disko.nix
    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "quantum";

  # FIXME: this should adapt to different monitor configurations
  # specifically 1, 3, and 4 monitor(s)
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144 --pos 0x0 --brightness 0.5 --output DP-2 --primary --mode 1920x1080 --rate 144 --right-of DP-0 --brightness 0.5 --output DP-4 --mode 1920x1080 --rate 144 --right-of DP-2 --brightness 0.5 --output HDMI-0 --mode 1920x1080 --rate 60 --right-of DP-4 --brightness 1
  '';

  base = {
    user.jeff.homeConfig = {
      xsession.windowManager.bspwm.monitors = {
        DP-0 = [ "L1" "L2" "L3" ];
        DP-2 = [ "M1" "M2" "M3" ];
        DP-4 = [ "R1" "R2" "R3" ];
        HDMI-0 = [ "P" ];
      };
    };

    nvidia = {
      enable = true;
      patchNvenc = true;
      patchNvfbc = true;
    };
  };

  hardware.bluetooth.enable = true;

  nix.settings.trusted-users = [ "jeff" ];
}
