{
  base.vikunja = {
    enable = true;
    frontendScheme = "http";
    frontendHostname = "vikunja.hydrogen.lan";
  };

  services.caddy.virtualHosts."http://vikunja.hydrogen.lan".extraConfig = ''
    reverse_proxy http://127.0.0.1:3456
  '';
}
