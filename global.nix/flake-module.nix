{ homeModule, nixosModule }:
{ config, lib, options, ... }:
let
  inherit (lib)
    mapAttrs
    mkForce
    mkOption
    types
    ;
in
{
  options = {
    global = mkOption {
      type = types.anything;
      default = { };
    };

    __global = mkOption {
      type = types.list;
      default = { };
    };
  };

  config =
    {
      flake.__global = {
        _config = config;
        _options = options;

        modules = [ ({ ... }: { flake.cronk = 123; }) ];
      };

      # flake.__global.mkModule = flake: { ... }:
      #   let
      #     homeConfigurations = flake.homeConfigurations;
      #     nixosConfigurations = flake.nixosConfigurations;
      #   in
      #   {
      #     # flake = {
      #     #   homeConfigurations = mkForce (mapAttrs
      #     #     (_: module: { imports = [ module homeModule ]; })
      #     #     homeConfigurations);
      #     #
      #     #   nixosConfigurations = mkForce (mapAttrs
      #     #     (_: configuration: configuration.extendModules { modules = [ nixosModule ]; })
      #     #     nixosConfigurations);
      #     # };
      #   };
    };
}
