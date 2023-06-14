{ monitors, extraConfig ? "" }:
{ pkgs, ... }:

{
  xsession.windowManager.bspwm = {
    inherit monitors extraConfig;
    enable = true;
  };
}
