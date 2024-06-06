{ config, lib, pkgs, ... }:

{
  services = {
    caddy.virtualHosts."http://navidrome.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:4533
    '';

    navidrome = {
      enable = true;
      settings = {
        Address = "127.0.0.1";
        BaseUrl = "http://navidrome.hydrogen.lan";
        Port = 4533;
        MusicFolder = "/data/music";
        DataFolder = "/var/lib/navidrome";
      };
    };
  };

  systemd.services.navidrome.serviceConfig = lib.mkForce {
    ExecStart =
      let
        cfg = config.services.navidrome;
        settingsFormat = pkgs.formats.json { };
      in
      "${cfg.package}/bin/navidrome --configfile ${settingsFormat.generate "navidrome.json" cfg.settings}";

    Restart = "always";
    User = "navidrome";
    WorkingDirectory = "/var/lib/navidrome";
  };

  users.groups.navidrome = { };

  users.users.navidrome = {
    description = "Navidrome Service User";
    home = "/var/lib/navidrome";
    createHome = true;
    isSystemUser = true;
    group = "navidrome";
  };
}
