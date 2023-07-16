{ pkgs, ... }:

{
  home = rec {
    username = "jeff";
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      DP-0 = [ "L1" "L2" "L3" ];
      DP-2 = [ "M1" "M2" "M3" ];
      DP-4 = [ "R1" "R2" "R3" ];
      HDMI-0 = [ "P" ];
    };
    extraConfig = ''
      ${pkgs.dunst}/bin/dunst &
      ${pkgs.procps}/bin/pidof xwinwrap || ${pkgs.flake.xwinwrap}/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- ${pkgs.mpv}/bin/mpv -wid WID --loop --no-audio ${../../wallpapers/animated.mkv}
    '';
  };

  base.dunst.enable = true;
  base.firefox.enable = true;
  base.fish.enable = true;
  base.git.enable = true;
  base.kitty.enable = true;
  base.neofetch.enable = true;
  base.rofi.enable = true;

  base.sxhkd = {
    enable = true;
    desktopOrder = "1,4,7,2,5,8,3,6,9,10";
  };

  base.vscode.enable = true;
  base.vscode.fontSize = 15;
}
