{ monitor ? 0, notificationLimit ? 20, origin ? "top-right", }:
{ lib, pkgs, ... }:

{
  services.dunst = lib.mkMerge [
    {
      enable = true;
      settings.global = {
        inherit monitor origin;
        notification_limit = notificationLimit;
      };
    }
  ];
}
