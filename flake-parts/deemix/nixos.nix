{ config, lib, pkgs, self, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.base.deemix-server;
in
{
  options.base.deemix-server = {
    enable = mkEnableOption "Deemix Server";
    port = mkOption {
      type = types.port;
      default = 6595;
    };
    openPort = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    users.groups.deemix = { };
    users.users.deemix = {
      description = "Deemix Server User";
      home = "/var/lib/deemix";
      createHome = true;
      isSystemUser = true;
      group = "deemix";
    };

    systemd.services.deemix-server = {
      description = "Deemix Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = ''
          ${self.packages.${pkgs.system}.deemix-server}/bin/deemix-server --port ${toString cfg.port}
        '';
        PrivateTmp = false;
        Restart = "always";
        User = "deemix";
        WorkingDirectory = "/var/lib/deemix";
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openPort [ cfg.port ];
  };
}
