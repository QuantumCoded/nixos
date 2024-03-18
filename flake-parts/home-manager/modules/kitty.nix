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
      # HACK: this is downgraded because kitty still doesn't render neofetch svg
      package = pkgs.raccoon.kitty;
      theme = "Material Dark";
      # TODO: maybe font should go somewhere else, no promise Nerdfonts are installed in this module
      font.name = "MesloLG Nerd Font";
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        confirm_os_window_close = 0;

        # tab bar
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_syle = "angled";
        tab_title_template = "{title}{ ' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      };
    };
  };
}
