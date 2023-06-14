{ terminal ? null }:
{ lib, pkgs, ... }:

{
  programs.rofi = {
    inherit terminal;
    enable = true;
    font = "FiraCode Nerd Font Mono 10";
  };
}
