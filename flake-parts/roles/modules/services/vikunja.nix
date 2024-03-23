{
  base.vikunja = {
    enable = true;
    frontendScheme = "http";
    frontendHostname = "vikunja.hydrogen.lan";
  };

  fileSystems."/var/lib/vikunja" = {
    device = "/data/services/vikunja";
    options = [ "bind" ];
  };

  services.caddy.virtualHosts."http://vikunja.hydrogen.lan".extraConfig = ''
    reverse_proxy http://127.0.0.1:3456
  '';
}
