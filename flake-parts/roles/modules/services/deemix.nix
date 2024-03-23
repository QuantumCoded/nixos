{
  base.deemix-server.enable = true;

  fileSystems."/var/lib/deemix" = {
    device = "/data/services/deemix";
    options = [ "bind" ];
  };

  services.caddy.virtualHosts."http://deemix.hydrogen.lan".extraConfig = ''
    reverse_proxy http://127.0.0.1:6595
  '';
}
