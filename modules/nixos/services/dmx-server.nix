{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.base.dmx-server;
in
{
  options.base.dmx-server = {
    enable = mkEnableOption "Nondescript Music Server";
    port = mkOption {
      type = types.port;
      default = 6595;
    };
  };

  config = mkIf cfg.enable {
    users.groups.dmx = {};
    users.users.dmx = {
      description = "Nondescript Music Server Service User";
      home = "/var/lib/dmx";
      createHome = true;
      isSystemUser = true;
      group = "dmx";
    };

    systemd.services.dmx-server = {
      description = "Nondescript Music Server :)";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = ''
          ${pkgs.flake.dmx-server}/bin/dmx-server --port ${toString cfg.port}
        '';
        Restart = "always";
        User = "dmx";
        WorkingDirectory = "/var/lib/dmx";
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
