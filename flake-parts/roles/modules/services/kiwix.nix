{
  fileSystems."/var/lib/kiwix" = {
    device = "/data/services/kiwix";
    options = [ "bind" ];
  };

  base.kiwix.enable = true;

  services = {
    caddy.virtualHosts = {
      "http://kiwix.hydrogen.lan".extraConfig = ''
        reverse_proxy http://127.0.0.1:3040
      '';

      "https://kiwix.hydrogen.lan".extraConfig = ''
        reverse_proxy http://127.0.0.1:3040
        tls internal
      '';
    };
  };

}
