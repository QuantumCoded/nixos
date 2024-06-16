{ pkgs, ... }:

{
  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.host = {
      enable = true;
      name = "host";

      hostPackages = with pkgs; [
        bash
        coreutils
        curl
        gawk
        gitMinimal
        gnused
        nodejs
        nix
      ];

      settings = {
        cache = {
          enabled = true;
          port = 3002;
          host = "127.0.0.1";
        };

        repository = {
          ENABLE_PUSH_CREATE_USER = true;
          DEFAULT_PUSH_CREATE_PRIVATE = false;
        };
      };

      url = "http://git.hydrogen.lan/";
      tokenFile = "/var/lib/runner_token";

      labels = [
        "native:host"
        "self-hosted"
      ];
    };
  };

  systemd = {
    services = {
      gitea-runner-host.environment.HOME = "/var/lib/gitea-runner/host";

      forgejo-runner-registry = {
        wantedBy = [ "foregejo.service" ];
        requiredBy = [ "gitea-runner-host.service" ];
        before = [ "gitea-runner-host.service" ];
        after = [ "systemd-tmpfiles-setup.service" "postgresql.service" ];
        requires = [ "forgejo.service" ];

        environment.GITEA_WORK_DIR = "/var/lib/forgejo";

        path = with pkgs; [
          forgejo-runner
          forgejo
          gnused
        ];

        serviceConfig = {
          Type = "oneshot";
          User = "forgejo";
          Group = "forgejo";
          ExecStart = pkgs.writeShellScript "register.sh" ''
            ${pkgs.forgejo}/bin/gitea actions generate-runner-token | ${pkgs.gnused}/bin/sed s/^/TOKEN=/ > /var/lib/runner_token
          '';
          RemainAfterExit = 1;
        };
      };
    };

    tmpfiles.rules = [
      "f /var/lib/runner_token 0644 forgejo forgejo"
    ];
  };
}
