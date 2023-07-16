{ pkgs, ... }:

{
  imports = [
    ../../roles/desktop.nix

    ./hardware.nix
    ./nvidia.nix
    ./storage.nix
  ];

  networking.hostName = "quantum";

  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 144 --pos 0x0 --output DP-2 --primary --mode 1920x1080 --rate 144 --right-of DP-0 --output DP-4 --mode 1920x1080 --rate 144 --right-of DP-2 --output HDMI-0 --mode 1920x1080 --rate 60 --right-of DP-4
  '';
}
