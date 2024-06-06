{ config, ... }:

{
  age.secrets.pgadmin.file = ../../../../secrets/pgadmin.age;

  services = {
    caddy.virtualHosts."http://pgadmin.hydrogen.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:5050
    '';

    pgadmin = {
      enable = true;
      initialEmail = "QuantumCoded@users.noreply.github.com";
      initialPasswordFile = config.age.secrets.pgadmin.path;
    };
  };
}
