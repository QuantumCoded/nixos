{ pkgs, ... }:

{
  services = {
    caddy.virtualHosts."http://searx.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8888
    '';

    searx = {
      enable = true;
      package = pkgs.searxng;
      # https://github.com/searx/searx/blob/master/searx/settings.yml
      settings = {
        server = {
          base_url = "http://searx.hydrogen.lan/";
          # HACK: use an environment file to set this key from an encypted file
          secret_key = "ca612e3566fdfd7cf7efe2b1c9349f461158d07cb78a3750e5c5be686aa8ebdc";
        };
      };
    };
  };
}
