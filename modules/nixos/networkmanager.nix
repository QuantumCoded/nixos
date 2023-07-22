{ config, lib, ... }:
let
  inherit (lib)
    mapAttrs
    mkEnableOption
    mkOption
    types
    ;

  cfg = config.base.networkmanager;

  mkConnection = connection: secret: {
    file = secret;
    path = "/etc/NetworkManager/system-connections/${connection}.nmconnection";
    mode = "400";
    owner = "root";
    group = "root";
  };
in
{
  options.base.networkmanager = {
    enable = mkEnableOption "NetworkManager";
    connections = mkOption {
      type = with types; attrsOf path;
      default = { };
    };
  };

  config = {
    networking.networkmanager.enable = cfg.enable;
    age.secrets = mapAttrs mkConnection cfg.connections;
  };
}
