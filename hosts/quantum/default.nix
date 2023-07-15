{ pkgs, ... }:

{
  imports = [
    ../../roles/desktop.nix
    ./hardware.nix
    ./nvidia.nix
    ./storage.nix
  ];

  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144 --pos 0x0 --output DP-2 --primary --mode 1920x1080 --rate 144 --right-of DP-0 --output DP-4 --mode 1920x1080 --rate 144 --right-of DP-2 --output HDMI-0 --mode 1920x1080 --rate 60 --right-of DP-4
  '';

  # set users and usernames here?

  # TODO: enable this again
  # home-manager.users."jeff" = {
  #   xsession.windowManager.bspwm = {
  #     monitors = {
  #       DP-0 = [ "L1" "L2" "L3" ];
  #       DP-2 = [ "M1" "M2" "M3" ];
  #       DP-4 = [ "R1" "R2" "R3" ];
  #       HDMI-0 = [ "P" ];
  #     };

  #     # TODO: this should probably be differentiated on desktop/laptop roles, not by host
  #     extraConfig = ''
  #       ${pkgs.dunst}/bin/dunst &
  #       ${pkgs.procps}/bin/pidof xwinwrap || ${pkgs.flake.xwinwrap}/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- ${pkgs.mpv}/bin/mpv -wid WID --loop --no-audio ${../../wallpapers/animated.mkv}
  #     '';
  #   };
  # };
}
