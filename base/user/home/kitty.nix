{ package ? null }:
{ lib, pkgs, ... }:

{
  programs.kitty = lib.mkMerge [
    {
      enable = true;
      font.name = "MesloLG Nerd Font";
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
    }

    (lib.mkIf (package != null) { inherit package; })
  ];
}
