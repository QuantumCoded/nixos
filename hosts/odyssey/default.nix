{
  imports = [
    ../../roles/laptop.nix
    ../../roles/workstation.nix

    ./hardware.nix
    ./storage.nix
  ];

  networking.hostName = "odyssey";

  base.homeConfig = {
    xsession.windowManager.bspwm.monitors = {
      eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
    };
  };

  hardware.bluetooth.enable = true;
}
