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
      ${pkgs.procps}/bin/pkill sxhkd && sxhkd &
      ${pkgs.dunst}/bin/dunst &
      ${pkgs.feh}/bin/feh --bg-max ${../../wallpapers/wallpaper.jpg}
    '';
  };

  services.pass-secret-service.enable = true;

  base = {
    dunst.enable = true;
    firefox.enable = true;
    fish.enable = true;
    git.enable = true;
    kitty.enable = true;
    neofetch.enable = true;
    rofi.enable = true;
    sxhkd.enable = true;
    vscode.enable = true;
    fish.tide.enable = true;
  };
}
