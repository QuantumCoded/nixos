{ config, pkgs, ... }:

{
  age.secrets = {
    woodpecker-agent-env.file = ../../../../secrets/woodpecker-agent-env.age;
    woodpecker-server-env.file = ../../../../secrets/woodpecker-server-env.age;
  };

  services = {
    caddy.virtualHosts."http://woodpecker.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8000
    '';

    postgresql = {
      ensureDatabases = [ "woodpecker" ];
      ensureUsers = [
        {
          name = "woodpecker";
          ensureDBOwnership = true;
        }
      ];

      authentication = ''
        local woodpecker woodpecker trust
      '';
    };

    woodpecker-server = {
      enable = true;

      package = pkgs.unstable.woodpecker-server;

      environment = {
        WOODPECKER_HOST = "http://woodpecker.hydrogen.lan";
        WOODPECKER_OPEN = "false";
        WOODPECKER_ADMIN = "QuantumCoded,woodpecker-ci";
        WOODPECKER_DATABASE_DRIVER = "postgres";

        WOODPECKER_GITEA = "true";
        WOODPECKER_GITEA_URL = "http://git.hydrogen.lan";
        WOODPECKER_GITEA_CLIENT = "7ca40157-4f4f-460b-9624-796aa3a783bb";

        # WOODPECKER_GITHUB = "true";
        WOODPECKER_GITHUB_CLIENT = "Ov23lilAPhiQgitVOlAB";
      };

      environmentFile = config.age.secrets.woodpecker-server-env.path;
    };

    woodpecker-agents = {
      agents = {
        docker = {
          enable = true;

          extraGroups = [ "docker" ];

          environment = {
            WOODPECKER_MAX_WORKFLOWS = "4";
            WOODPECKER_HOSTNAME = "hydrogen";
            WOODPECKER_BACKEND = "docker";
          };

          environmentFile = [ config.age.secrets.woodpecker-agent-env.path ];
        };
      };
    };
  };

  virtualisation.docker.enable = true;
}
