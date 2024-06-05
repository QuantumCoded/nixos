{
  services = {
    caddy.virtualHosts."http://vikunja.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3456
    '';

    postgresql = {
      ensureDatabases = [ "vikunja" ];
      ensureUsers = [
        {
          name = "vikunja";
          ensureDBOwnership = true;
        }
      ];
    };

    vikunja = {
      enable = true;

      database = {
        type = "postgres";
        host = "/run/postgresql";
      };

      frontendScheme = "http";
      frontendHostname = "vikunja.hydrogen.lan";
    };
  };
}
