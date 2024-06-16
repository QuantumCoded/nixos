{ lib, ... }:

{
  services = {
    caddy.virtualHosts."http://git.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3001
    '';

    forgejo = {
      enable = true;

      database = {
        type = "postgres";
        socket = "/run/postgresql";
      };

      settings = {
        DEFAULT.APP_NAME = "Forgejo Internal";

        repository.DEFAULT_BRANCH = "master";

        server = {
          ROOT_URL = "http://git.hydrogen.lan/";
          DOMAIN = "git.hydrogen.lan";
          HTTP_PORT = 3001;
        };

        ui.DEFAULT_THEME = "gitea-dark";

        migrations.ALLOWED_DOMAINS = lib.concatStringsSep "," [
          "codex.cypress.local"
        ];

        webhook.ALLOWED_HOST_LIST = lib.concatStringsSep "," [
          "woodpecker.hydrogen.lan"
        ];
      };
    };

    postgresql = {
      ensureDatabases = [ "forgejo" ];
      authentication = ''
        local forgejo forgejo trust
      '';

      ensureUsers = [{
        name = "forgejo";
        ensureDBOwnership = true;
      }];
    };
  };
}
