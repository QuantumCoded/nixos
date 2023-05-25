{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font Mono 13";
    terminal = "${pkgs.kitty}/bin/kitty";
  };
}