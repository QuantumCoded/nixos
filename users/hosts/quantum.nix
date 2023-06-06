{ pkgs, ... }:
let
  # fork of pkgs.xwinwrap with support for spanning multi monitors
  xwinwrap = pkgs.stdenv.mkDerivation {
    name = "xwinwrap";

    src = pkgs.fetchFromGitHub {
      owner = "ujjwal96";
      repo = "xwinwrap";
      rev = "ec32e9b72539de7e1553a4f70345166107b431f7";
      hash = "sha256-6ar1HgEWIc/20MJzy07FvuwV2sXBdFumzzVRibh5dlA=";
    };

    buildInputs = with pkgs.xorg; [
      libX11
      libXext
      libXrender
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp xwinwrap $out/bin
    '';
  };
in
{
  programs.vscode.userSettings = {
    # Change the font size.
    "editor.fontSize" = 15;
  };

  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      DP-0 = [ "L1" "L2" "L3" ];
      DP-2 = [ "M1" "M2" "M3" ];
      DP-4 = [ "R1" "R2" "R3" ];
      HDMI-0 = [ "P" ];
    };

    # Stylix does this step in `xsession.initExtra`, but that will run any time X11 loads.
    # Using xsession.windowManager.bspwm.extraConfig prevents the wallpaper from being set in plasma.
    extraConfig = ''
      ${pkgs.procps}/bin/pidof xwinwrap || ${xwinwrap}/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- ${pkgs.mpv}/bin/mpv -wid WID --loop --no-audio ${../../wallpapers/animated.mkv}
    '';
  };

  services.sxhkd.keybindings = {
    # focus or send to the given desktop
    "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1,4,7,2,5,8,3,6,9,10}'";
  };
}
