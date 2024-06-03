{
  base.ankisyncd.enable = true;

  fileSystems."/var/lib/ankisync" = {
    device = "/data/services/ankisync";
    options = [ "bind" ];
  };

  services.caddy.virtualHosts."http://ankisync.hydrogen.lan".extraConfig = ''
    reverse_proxy http://127.0.0.1:27701
  '';
}
