{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    };
  };
}
