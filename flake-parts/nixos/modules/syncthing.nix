{ config, lib, ... }:
let
  inherit (lib)
    attrNames
    elem
    filterAttrs
    mapAttrs
    mapAttrsToList
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.base.syncthing;
in
{
  options.base.syncthing = {
    enable = mkEnableOption "syncthing";

    deviceName = mkOption {
      type = types.str;
      default = config.networking.hostName;
    };

    networks = mkOption {
      type = with types; attrsOf (submodule {
        options = {
          devices = mkOption {
            type = attrsOf attrs;
            default = { };
          };

          folders = mkOption {
            type = attrsOf attrs;
            default = { };
          };
        };
      });

      default = { };
    };
  };

  config = mkIf cfg.enable (
    let
      networkConfigurations = mapAttrsToList
        (_: network:
          let
            thisDevice = network.devices.${cfg.deviceName};

            networkDevices = mapAttrs
              (_: device: { inherit (device) id; })
              (filterAttrs
                (deviceName: _: deviceName != cfg.deviceName)
                network.devices);

            deviceFolders = mapAttrs
              (folderName: folder: {
                devices = attrNames (filterAttrs
                  (deviceName: _: elem folderName (attrNames
                    network.devices.${deviceName}.folders))
                  networkDevices);
              } // folder)
              thisDevice.folders;

            networkFolders = filterAttrs
              (folderName: _: elem folderName (attrNames deviceFolders))
              network.folders;
          in
          {
            settings = {
              devices = networkDevices;

              folders = mkMerge [
                deviceFolders
                networkFolders
              ];
            };
          }
        )
        cfg.networks;
    in
    {
      services.syncthing = mkMerge ([
        { enable = true; }
      ] ++ networkConfigurations);
    }
  );
}
