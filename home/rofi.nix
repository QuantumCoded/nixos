{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    font = "FiraCode Nerd Font Mono 10";
    terminal = "${pkgs.kitty}/bin/kitty";
  };
}