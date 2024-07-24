{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.zoxide;
in
{
  options.base.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    programs = {
      zoxide.enable = true;

      fish.interactiveShellInit = mkIf config.programs.fish.enable ''
        ${config.programs.zoxide.package}/bin/zoxide init fish | source
        alias cd=z
      '';
    };
  };
}
