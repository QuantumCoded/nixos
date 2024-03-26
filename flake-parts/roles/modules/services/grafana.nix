{
  fileSystems."/var/lib/grafana" = {
    device = "/data/services/grafana";
    options = [ "bind" ];
  };

  services = {
    caddy.virtualHosts."http://grafana.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3300
    '';

    grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3300;
          domain = "graphana.hydrogen.lan";
          root_url = "http://graphana.hydrogen.lan";
        };
      };
    };
  };
}
