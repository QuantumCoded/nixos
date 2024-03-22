{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.base.ankisync;
in
{
  options.base.ankisync = {
    enable = mkEnableOption "Anki Sync Server";
    port = mkOption {
      type = types.port;
      default = 27701;
    };
    openPort = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    users.groups.ankisync = { };
    users.users.ankisync = {
      description = "Anki Sync Server User";
      home = "/var/lib/ankisync";
      createHome = true;
      isSystemUser = true;
      group = "ankisync";
    };

    systemd.services.ankisync = {
      description = "Anki Sync Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      environment = {
        # FIXME: this should be moved to an encrypted env file
        SYNC_USER1 = "jeff:password";
        SYNC_PORT = toString cfg.port;
        SYNC_BASE = "/var/lib/ankisync";
      };
      serviceConfig = {
        ExecStart = ''
          ${pkgs.anki-bin}/bin/anki --syncserver
        '';
        Restart = "always";
        User = "ankisync";
        WorkingDirectory = "/var/lib/ankisync";
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openPort [ cfg.port ];
  };
}

