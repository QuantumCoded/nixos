{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.wireguard;
in
{

  options.base.wireguard.enable = mkEnableOption "Wireguard Autonetworking";

  config = mkIf cfg.enable {
    networking = {
      hosts = {
        "172.16.2.3" = [
          "cypress.local"
          "sesh.cypress.local"
          "tape.cypress.local"
          "codex.cypress.local"
          "pgadmin.cypress.local"
        ];
      };

      wireguard = {
        # interfaces.asluni.presistentKeepAlive = 30;

        networks.asluni.autoConfig = {
          interface = true;
          peers = true;
        };
      };
    };
  };
}
