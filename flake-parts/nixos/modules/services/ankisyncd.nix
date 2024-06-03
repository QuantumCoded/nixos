{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.base.ankisyncd;
in
{
  options.base.ankisyncd = {
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
    users.groups.ankisyncd = { };
    users.users.ankisyncd = {
      description = "Anki Sync Server User";
      home = "/var/lib/ankisyncd";
      createHome = true;
      isSystemUser = true;
      group = "ankisyncd";
    };

    systemd.services.ankisyncd = {
      description = "Anki Sync Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      environment = {
        # FIXME: this should be moved to an encrypted env file
        SYNC_USER1 = "jeff:password";
        SYNC_PORT = toString cfg.port;
        SYNC_BASE = "/var/lib/ankisyncd";
      };
      serviceConfig = {
        ExecStart = ''
          ${pkgs.anki-bin}/bin/anki --syncserver
        '';
        Restart = "always";
        User = "ankisyncd";
        WorkingDirectory = "/var/lib/ankisyncd";
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openPort [ cfg.port ];
  };
}

