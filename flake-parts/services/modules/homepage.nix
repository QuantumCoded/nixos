{ lib, ... }:
let
  inherit (lib)
    singleton
    ;
in
{
  services = {
    caddy.virtualHosts."http://home.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8082
    '';

    homepage-dashboard = {
      enable = true;

      widgets = [
        {
          resources = {
            cpu = true;
            disk = "/data";
            memory = true;
          };
        }
        {
          search = {
            provider = "custom";
            url = "http://searx.hydrogen.lan/search?q=";
            target = "_blank";
          };
        }
      ];

      settings = {
        title = "Homelab";
        theme = "dark";
        color = "neutral";
      };

      bookmarks = [
        {
          "Services" = [
            {
              "Forgejo" = singleton {
                href = "http://git.hydrogen.lan/";
                icon = "si-forgejo-#FB923C";
              };
            }
            {
              "Grafana" = singleton {
                href = "http://grafana.hydrogen.lan/";
                icon = "si-grafana-#F46800";
              };
            }
            {
              "Invidious" = singleton {
                href = "http://invidious.hydrogen.lan/";
                icon = "https://avatars.githubusercontent.com/u/68407447";
              };
            }
            {
              "Jellyfin" = singleton {
                href = "http://jellyfin.hydrogen.lan/";
                icon = "si-jellyfin-#B163D0";
              };
            }
            {
              "pgAdmin" = singleton {
                href = "http://pgadmin.hydrogen.lan/";
                icon = "si-postgresql-#4169E1";
              };
            }
            {
              "Searx" = singleton {
                href = "http://searx.hydrogen.lan/";
                icon = "si-searxng-#3050FF";
              };
            }
            {
              "Syncthing" = singleton {
                href = "http://syncthing.hydrogen.lan/";
                icon = "si-syncthing-#0891D1";
              };
            }
            {
              "Vikunja" = singleton {
                href = "http://vikunja.hydrogen.lan/";
                icon = "https://avatars.githubusercontent.com/u/41270016";
              };
            }
            {
              "Woodpecker" = singleton {
                href = "http://Woodpecker.hydrogen.lan/";
                icon = "https://avatars.githubusercontent.com/u/84780935";
              };
            }
          ];
        }
      ];
    };
  };
}
