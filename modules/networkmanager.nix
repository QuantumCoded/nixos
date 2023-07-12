{ config, inputs, lib, ... }:
let
  inherit (lib)
    mapAttrsToList
    mkEnableOption
    mkMerge
    mkOption
    types
    ;

  cfg = config.base.networkmanager;

  mkConnection = connection: secret: {
    age.secrets.${connection} = {
      file = secret;
      path = "/etc/NetworkManager/system-connections/${connection}.nmconnection";
      mode = "400";
      owner = "root";
      group = "root";
    };
  };
in
{
  imports = [ inputs.agenix.nixosModules.default ];

  options.base.networkmanager = {
    enable = mkEnableOption "NetworkManager";
    connections = mkOption {
      type = with types; attrsOf path;
      default = { };
    };
  };

  config = mkMerge [
    { networking.networkmanager.enable = cfg.enable; }
  ]
  ++ (mapAttrsToList mkConnection cfg.connections);
}
