{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.kitty;
in
{
  options.base.kitty = {
    enable = mkEnableOption "Kitty";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      # TODO: maybe font should go somewhere else, no promise Nerdfonts are installed in this module
      font.name = "MesloLG Nerd Font";
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
    };
  };
}
