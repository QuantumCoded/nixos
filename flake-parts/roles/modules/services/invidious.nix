{
  services = {
    caddy.virtualHosts."http://invidious.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3033
    '';

    invidious = {
      enable = true;
      port = 3033;
      # HACK: invidious won't start without this being set
      # a secure key should be used and encrypted
      settings.hmac_key = "eeth5na2aing5xaiP3Uu";
    };
  };
}
