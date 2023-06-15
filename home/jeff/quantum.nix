{ fpkgs ? null
, pkgs ? fpkgs
, self
, ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  xwinwrap = self.packages.${system}.xwinwrap;
in
{
  imports = [
    ({ pkgs, ... }: {
      imports = [
        # Home
        (import ../../base/user/home/fish { })
        (import ../../base/user/home/neofetch { })
        (import ../../base/user/home/bspwm.nix {
          monitors = {
            DP-0 = [ "L1" "L2" "L3" ];
            DP-2 = [ "M1" "M2" "M3" ];
            DP-4 = [ "R1" "R2" "R3" ];
            HDMI-0 = [ "P" ];
          };

          extraConfig = ''
            ${pkgs.procps}/bin/pidof xwinwrap || ${xwinwrap}/bin/xwinwrap -fs -fdt -ni -b -nf -un -o 1.0 -- ${pkgs.mpv}/bin/mpv -wid WID --loop --no-audio ${../../wallpapers/animated.mkv}
          '';
        })
        (import ../../base/user/home/firefox.nix { })
        (import ../../base/user/home/git.nix { userName = "QuantumCoded"; })
        (import ../../base/user/home/home-manager.nix { userName = "jeff"; })
        (import ../../base/user/home/kitty.nix { package = pkgs.raccoon.kitty; })
        (import ../../base/user/home/rofi.nix { })
        (import ../../base/user/home/sxhkd.nix { desktopOrder = "1,4,7,2,5,8,3,6,9,10"; })
        (import ../../base/user/home/vscode.nix { fontSize = 15; })

        # Style
        (import ../../base/user/style/kitty.nix { })
        (import ../../base/user/style/scheme.nix { })

        # Overlays
        (import ../../base/overlays.nix { })
      ];
    })
  ];
}
