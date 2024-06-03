{
  base.deemix-server.enable = true;

  services.caddy.virtualHosts."http://deemix.hydrogen.lan".extraConfig = ''
    reverse_proxy http://127.0.0.1:6595
  '';
}
