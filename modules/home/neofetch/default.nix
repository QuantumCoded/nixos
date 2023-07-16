{ config, inputs, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.neofetch;
in
{
  options.base.neofetch = {
    enable = mkEnableOption "Enable Neofetch";
  };

  config = mkIf cfg.enable {
    home.file = {
      ".config/neofetch/config.conf".source = ./config.conf;
      ".config/neofetch/logo.svg" = {
        source = ./logo.svg;

        onChange = ''
          ${pkgs.neofetch}/bin/neofetch --clean
        '';
      };
    };
  };
}
