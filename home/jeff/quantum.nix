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
      ${pkgs.procps}/bin/pidof xwinwrap || ${pkgs.flake.xwinwrap}/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- ${pkgs.mpv}/bin/mpv -wid WID --loop --no-audio ${../../wallpapers/animated.mkv}
    '';
  };

  services.pass-secret-service.enable = true;

  base.dunst = {
    enable = true;
    origin = "bottom-left";
    monitor = 1;
  };

  base.firefox.enable = true;
  base.fish.enable = true;
  base.git.enable = true;
  base.kitty.enable = true;
  base.neofetch.enable = true;
  base.rofi = {
    enable = true;
    websites = {
      enable = true;
      sites = {
        "Search NixOS Packages" = "https://search.nixos.org/packages";
        "Nix Builtins" = "https://nixos.org/manual/nix/stable/language/builtins.html";
        "Nix Lib & Builtins" = "https://teu5us.github.io/nix-lib.html";
        "Nixpkgs Github" = "https://github.com/NixOS/nixpkgs";
        "NixOS Appendix A" = "https://nixos.org/manual/nixos/unstable/options.html";
        "Home Manager Appendix A" = "https://nix-community.github.io/home-manager/options.html";
        "Github" = "https://github.com";
        "Last.FM" = "https://last.fm";
      };
    };
  };

  base.sxhkd = {
    enable = true;
    desktopOrder = "1,4,7,2,5,8,3,6,9,10";
  };

  base.vscode.enable = true;
  base.vscode.fontSize = 15;

  base.fish.tide.enable = true;
}
