{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.masterpdfeditor;
in
{
  options.base.masterpdfeditor = {
    enable = mkEnableOption "MasterPDFEditor";
  };

  config = mkIf cfg.enable {
    # Block masterpdfeditor from phoning home
    networking.hosts = {
      "0.0.0.0" = [ "reg.code-industry.net" ];
    };

    environment.systemPackages = with pkgs; [
      masterpdfeditor
    ];
  };
}
