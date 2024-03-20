{ pkgs, ... }:

{
  # MySQL
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureUsers = [{
      name = "jeff";
      ensurePermissions = {
        "music.*" = "ALL PRIVILEGES";
        "testing.*" = "ALL PRIVILEGES";
        "dbms.*" = "ALL PRIVILEGES";
      };
    }];
    ensureDatabases = [ "music" "testing" "dbms" ];
  };
}
