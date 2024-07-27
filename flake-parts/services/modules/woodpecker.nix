{ config, flakeRoot, lib, pkgs, ... }:

{
  age.secrets = {
    woodpecker-agent-env.file = flakeRoot + "/secrets/woodpecker-agent-env.age";
    woodpecker-server-env.file = flakeRoot + "/secrets/woodpecker-server-env.age";
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
      package = pkgs.tapir.woodpecker-server;

      environment = {
        WOODPECKER_HOST = "http://woodpecker.hydrogen.lan";
        WOODPECKER_OPEN = "false";
        WOODPECKER_ADMIN = "QuantumCoded,woodpecker-ci";
        WOODPECKER_DATABASE_DRIVER = "postgres";

        WOODPECKER_GITEA = "true";
        WOODPECKER_GITEA_URL = "http://git.hydrogen.lan";
      };

      environmentFile = config.age.secrets.woodpecker-server-env.path;
    };

    woodpecker-agents.agents.docker = {
      enable = true;

      package = pkgs.tapir.woodpecker-agent;

      # TODO: switch to podman
      # extraGroups = [ "podman" ];

      extraGroups = [ "docker" ];

      environment = {
        WOODPECKER_MAX_WORKFLOWS = "16";
        WOODPECKER_HOSTNAME = "hydrogen";
        # TODO: switch to podman
        # WOODPECKER_BACKEN = "docker";
        # DOCKER_HOST = "unix:///run/podman/podman.sock";
      };

      environmentFile = [ config.age.secrets.woodpecker-agent-env.path ];
    };
  };

  # TODO: switch to podman
  # systemd.services.woodpecker-agent-docker = {
  #   after = [ "podman.socket" "woodpecker-server.service" ];
  #   serviceConfig.BindPaths = [
  #     "/run/podman/podman.sock"
  #   ];
  # };

  virtualisation = {
    # TODO: switch to podman
    docker.enable = true;

    podman =
      let
        cfg = config.virtualisation.podman;

        # taken from https://github.com/NixOS/nixpkgs/blob/0b8e7a1ae5a94da2e1ee3f3030a32020f6254105/nixos/modules/virtualisation/podman/default.nix#L8-L13
        package = pkgs.unstable.podman.override {
          extraPackages = cfg.extraPackages
            # setuid shadow
            ++ [ "/run/wrappers" ]
            ++ lib.optional (config.boot.supportedFilesystems.zfs or false) config.boot.zfs.package;
        };
      in
      {
        # TODO: switch to podman
        # enable = true;

        inherit package;

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
