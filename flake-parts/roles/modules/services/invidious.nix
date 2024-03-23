{
  fileSystems."/var/lib/invidious" = {
    device = "/data/services/invidious";
    options = [ "bind" ];
  };

  services = {
    caddy.virtualHosts."http://invidious.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3000
    '';

    invidious = {
      enable = true;
      # HACK: invidious won't start without this being set
      # a secure key should be used and encrypted
      settings.hmac_key = "eeth5na2aing5xaiP3Uu";
    };
  };
}
