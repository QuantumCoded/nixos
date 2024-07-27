{ config, flakeRoot, ... }:

{
  age.secrets.attic-credentials.file = flakeRoot + "/secrets/attic-credentials.age";

  services = {
    atticd = {
      enable = true;

      credentialsFile = config.age.secrets.attic-credentials.path;

      settings = {
        listen = "[::]:4623";
        api-endpoint = "http://attic.hydrogen.lan/";
        database.url = "postgres://atticd?host=/run/postgresql";
        require-proof-of-possession = false;

        # Warning: If you change any of the values here, it will be
        # difficult to reuse existing chunks for newly-uploaded NARs
        # since the cutpoints will be different. As a result, the
        # deduplication ratio will suffer for a while after the change.
        chunking = {
          # The minimum NAR size to trigger chunking
          #
          # If 0, chunking is disabled entirely for newly-uploaded NARs.
          # If 1, all NARs are chunked.
          nar-size-threshold = 64 * 1024; # 64 KiB

          # The preferred minimum size of a chunk, in bytes
          min-size = 16 * 1024; # 16 KiB

          # The preferred average size of a chunk, in bytes
          avg-size = 64 * 1024; # 64 KiB

          # The preferred maximum size of a chunk, in bytes
          max-size = 256 * 1024; # 256 KiB
        };
      };
    };

    caddy.virtualHosts."http://attic.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:4623
    '';

    postgresql = {
      ensureDatabases = [ "atticd" ];
      ensureUsers = [
        {
          name = "atticd";
          ensureDBOwnership = true;
        }
      ];
    };
  };

  systemd.services.atticd = {
    after = [ "postgresql.service" ];
    requires = [ "postgresql.service" ];
  };
}
