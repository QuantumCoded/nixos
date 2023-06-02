{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    # FIXME: Downgrading kitty 0.28.1 -> 0.26.2 to fix icat rendering error
    package = pkgs.racoon.kitty;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
  };
}
