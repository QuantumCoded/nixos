{ config, inputs, lib, self, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.user.jeff;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.base.user."jeff".enable = mkEnableOption "Jeff User";

  config = mkIf cfg.enable {

    home-manager.extraSpecialArgs = { inherit inputs self; };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users."jeff" = {
      imports = [
        ../home
        (../../home/jeff + "/${config.networking.hostName}.nix")
      ];

      programs.home-manager.enable = true;
    };
  };
}
