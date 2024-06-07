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

      # TODO: 2.5.0 from unstable breaks oauth, upgrade when stable
      package = pkgs.woodpecker-server;

      environment = {
        WOODPECKER_HOST = "http://woodpecker.hydrogen.lan";
        WOODPECKER_OPEN = "false";
        WOODPECKER_ADMIN = "QuantumCoded,woodpecker-ci";
        WOODPECKER_DATABASE_DRIVER = "postgres";

        WOODPECKER_GITEA = "true";
        WOODPECKER_GITEA_URL = "http://git.hydrogen.lan";
        WOODPECKER_GITEA_CLIENT = "ecac1705-43ea-4638-8269-ea88dad8919b";

        # WOODPECKER_GITHUB = "true";
        # WOODPECKER_GITHUB_CLIENT = "Ov23lilAPhiQgitVOlAB";
      };

      environmentFile = config.age.secrets.woodpecker-server-env.path;
    };

    woodpecker-agents.agents.docker = {
      enable = true;

      package = pkgs.woodpecker-agent;

      extraGroups = [ "podman" ];

      environment = {
        WOODPECKER_MAX_WORKFLOWS = "16";
        WOODPECKER_HOSTNAME = "hydrogen";
        WOODPECKER_BACKEN = "docker";
        DOCKER_HOST = "unix:///run/podman/podman.sock";
      };

      environmentFile = [ config.age.secrets.woodpecker-agent-env.path ];
    };
  };

  systemd.services.woodpecker-agent-docker = {
    after = [ "podman.socket" "woodpecker-server.service" ];
    serviceConfig.BindPaths = [
      "/run/podman/podman.sock"
    ];
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };

    lxc.systemConfig = ''
      lxc.cgroup.relative = 1
    '';
  };
}
