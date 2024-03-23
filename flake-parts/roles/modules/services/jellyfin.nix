{
  fileSystems."/var/lib/jellyfin" = {
    device = "/data/services/jellyfin";
    options = [ "bind" ];
  };

  services = {
    caddy.virtualHosts."http://jellyfin.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8096
    '';

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
