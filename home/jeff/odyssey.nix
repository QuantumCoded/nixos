{ ... }:

{
  imports = [
    ({ pkgs, ... }: {
      imports = [
        # Home
        (import ../../base/user/home/fish { })
        (import ../../base/user/home/neofetch { })
        (import ../../base/user/home/bspwm.nix {
          monitors = {
            eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
          };

          extraConfig = ''
            ${pkgs.procps}/bin/pidof feh || ${pkgs.feh}/bin/feh --no-fehbg --bg-scale ${../../wallpapers/wallpaper.jpg}
          '';
        })
        (import ../../base/user/home/firefox.nix { })
        (import ../../base/user/home/git.nix { userName = "QuantumCoded"; })
        (import ../../base/user/home/home-manager.nix { userName = "jeff"; })
        (import ../../base/user/home/kitty.nix { package = pkgs.raccoon.kitty; })
        (import ../../base/user/home/rofi.nix { })
        (import ../../base/user/home/sxhkd.nix { })
        (import ../../base/user/home/vscode.nix { })

        # Style
        (import ../../base/user/style/kitty.nix { })
        (import ../../base/user/style/scheme.nix { })

        # Overlays
        (import ../../base/overlays.nix { })
      ];
    })
  ];

  home.stateVersion = "23.05";
}
