{ config, lib, pkgs, ... }:
let
  inherit (lib)
    concatStringsSep
    mkEnableOption
    mkIf
    ;

  cfg = config.base.input;
in
{
  options.base.input = {
    enable = mkEnableOption "Input";
  };

  config = mkIf cfg.enable {
    services.xserver.xkb.options = concatStringsSep "," [
      "caps:swapescape"
      "compose:ralt"
    ];


    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        libsForQt5.fcitx5-qt
      ];
    };

    environment.sessionVariables = {
      # IME config
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";

      # Compose config
      XCOMPOSEFILE = ./XCompose;
    };
  };
}
