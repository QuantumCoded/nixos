{ pkgs, ... }:

{
  home = rec {
    username = "jeff";
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };

  xsession.windowManager.bspwm = {
    enable = true;

    extraConfig = ''
      ${pkgs.dunst}/bin/dunst &
      ${pkgs.procps}/bin/pidof xwinwrap || ${pkgs.flake.xwinwrap}/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- ${pkgs.mpv}/bin/mpv -wid WID --loop --no-audio ${../../wallpapers/animated.mkv}
    '';
  };

  base.dunst.enable = true;
  base.dunst.origin = "bottom-left";
  base.dunst.monitor = 1;

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
