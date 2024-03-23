{
  services = {
    caddy.virtualHosts."http://home.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8082
    '';

    homepage-dashboard.enable = true;
  };
}
