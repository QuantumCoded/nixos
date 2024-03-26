{
  fileSystems."/var/lib/postgresql" = {
    device = "/data/services/postgresql";
    options = [ "bind" ];
  };

  services.postgresql.enable = true;
}
