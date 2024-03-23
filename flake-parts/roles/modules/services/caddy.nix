{
  fileSystems."/var/lib/caddy" = {
    device = "/data/services/caddy";
    options = [ "bind" ];
  };

  services.caddy.enable = true;
}
