{ config, inputs, lib, self, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.user.jeff;
in
{
  options.base.user."jeff".enable = mkEnableOption "Jeff User";

  config = mkIf cfg.enable {
    home-manager.extraSpecialArgs = { inherit inputs self; };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users."jeff" = {
      imports = [
        ../home/fish
        ../home/neofetch
        ../home/dunst.nix
        ../home/kitty.nix
        ../home/rofi.nix
        ../home/sxhkd.nix
      ];

      programs.home-manager.enable = true;

      home = rec {
        username = "jeff";
        homeDirectory = "/home/${username}";
        stateVersion = "23.05";
      };

      xsession.windowManager.bspwm.enable = true;

      base.sxhkd.enable = true;
      # FIXME: should be split at the host
      base.sxhkd.desktopOrder = "1,4,7,2,5,8,3,6,9,10";
    };
  };
}
