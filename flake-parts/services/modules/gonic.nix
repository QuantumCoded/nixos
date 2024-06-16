{ config, lib, pkgs, ... }:

{
  services = {
    caddy.virtualHosts."http://gonic.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:4747
    '';

    gonic = {
      enable = true;
      settings = {
        music-path = map (dirname: "/data/music/${dirname}") [
          "bandcamp"
          "deezer"
          "other"
          "soulseek"
          "soundcloud"
          "youtube"
        ];

        playlists-path = "/var/lib/gonic/playlists";
        podcast-path = "/var/lib/gonic/podcasts";
        cache-path = "/var/lib/gonic/cache";
        db-path = "/var/lib/gonic/db";
        listen-addr = "127.0.0.1:4747";
        scan-interval = 60 * 24;
        scan-watcher-enabled = true;
        jukebox-enabled = true;
      };
    };
  };

  systemd.services.gonic.serviceConfig = lib.mkForce {
    ExecStart =
      let
        # these values are null by default but should not appear in the final config
        filteredSettings = lib.filterAttrs (n: v: !((n == "tls-cert" || n == "tls-key") && v == null)) config.services.gonic.settings;
        settingsFormat = pkgs.formats.keyValue {
          mkKeyValue = lib.generators.mkKeyValueDefault { } " ";
          listsAsDuplicateKeys = true;
        };
      in
      "${pkgs.gonic}/bin/gonic -config-path ${settingsFormat.generate "gonic" filteredSettings}";

    Restart = "always";
    User = "gonic";
    WorkingDirectory = "/var/lib/gonic";
  };

  users.groups.gonic = { };

  users.users.gonic = {
    description = "Gonic Service User";
    home = "/var/lib/gonic";
    createHome = true;
    isSystemUser = true;
    group = "gonic";
  };
}
