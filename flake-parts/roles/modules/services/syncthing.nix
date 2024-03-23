{
  fileSystems."/var/lib/syncthing" = {
    device = "/data/services/syncthing";
    options = [ "bind" ];
  };

  services = {
    caddy.virtualHosts."http://syncthing.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8384
    '';

    syncthing = {
      enable = true;
      # TODO: add devices
      settings.gui.insecureSkipHostcheck = true;
    };
  };
}
