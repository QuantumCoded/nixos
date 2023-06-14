{}:
{ inputs, ... }:

{
  imports = [ inputs.agenix.nixosModules.default ];

  # Get wireless network information from agenix.
  age.secrets = {
    wifi_5g = {
      file = ../../../../secrets/wifi_5g.age;
      path = "/etc/NetworkManager/system-connections/Home_5G.nmconnection";
      mode = "400";
      owner = "root";
      group = "root";
    };

    wifi = {
      file = ../../../../secrets/wifi.age;
      path = "/etc/NetworkManager/system-connections/Home.nmconnection";
      mode = "400";
      owner = "root";
      group = "root";
    };
  };
}
