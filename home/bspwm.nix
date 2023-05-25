{ ... }:
{
  xsession.windowManager.bspwm = {
    enable = true;

    # TODO: This needs to be updated to handle multiple machines
    monitors = {
      eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
    };
  };
}