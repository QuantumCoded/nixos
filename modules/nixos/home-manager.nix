{ config, inputs, lib, self, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    recursiveUpdate
    types
    ;

  cfg = config.base;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.base = {
    homeConfig = mkOption {
      type = types.attrs;
      default = { };
    };

    homeBaseConfig = mkOption {
      type = types.attrs;
      default = { };
    };

    user.jeff = {
      enable = mkEnableOption "Jeff User";

      homeConfig = mkOption {
        type = types.attrs;
        default = { };
      };

      baseConfig = mkOption {
        type = types.attrs;
        default = { };
      };
    };
  };

  config = mkIf cfg.user.jeff.enable {
    home-manager.extraSpecialArgs = { inherit inputs self; };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.jeff = mkMerge [
      cfg.homeConfig
      cfg.user.jeff.homeConfig
      {
        imports = [
          ../home
          (../../home/jeff + "/${config.networking.hostName}.nix")
        ];

        programs.home-manager.enable = true;

        base = recursiveUpdate
          cfg.homeBaseConfig
          cfg.user.jeff.baseConfig;
      }
    ];
  };
}
