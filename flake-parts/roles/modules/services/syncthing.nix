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
      openDefaultPorts = true;
      settings = {
        options = {
          listenAddresses = [
            "tcp://:22000"
            "quic://:22000"
          ];

          urAccepted = -1;
        };

        gui.insecureSkipHostcheck = true;
      };
    };
  };
}
