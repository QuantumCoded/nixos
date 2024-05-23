{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.base.kiwix;
in
{
  options.base.kiwix = {
    enable = mkEnableOption "Kiwix Server";
    port = mkOption {
      type = types.port;
      default = 3040;
    };
    openPort = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    users.groups.kiwix = { };
    users.users.kiwix = {
      description = "Kiwix Server User";
      home = "/var/lib/kiwix";
      createHome = true;
      isSystemUser = true;
      group = "kiwix";
    };

    systemd.services.kiwix = {
      description = "Kiwix Server";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = ''
          /bin/sh -c '${pkgs.kiwix-tools}/bin/kiwix-serve -i 127.0.0.1 -p ${toString cfg.port} *'
        '';
        Restart = "always";
        User = "kiwix";
        WorkingDirectory = "/var/lib/kiwix";
        StandardOutput = "journal";
        StandardError = "journal";
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openPort [ cfg.port ];
  };
}

