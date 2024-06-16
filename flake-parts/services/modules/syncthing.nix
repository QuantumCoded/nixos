{
  services = {
    caddy.virtualHosts."http://syncthing.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8384
    '';

    syncthing = {
      enable = true;
      openDefaultPorts = true;
      settings = {
        options = {
          globalAnnounceEnabled = false;
          relaysEnabled = false;
          startBrowser = false;
          natEnabled = false;
          autoUpgradeIntervalH = 0;
          urAccepted = -1;
          listenAddresses = [
            "tcp://:22000"
            "quic://:22000"
          ];
        };

        gui.insecureSkipHostcheck = true;
      };
    };
  };
}
