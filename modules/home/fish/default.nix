{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.fish;
in
{
  options.base.fish = {
    enable = mkEnableOption "Enable Fish";
    tide.enable = mkEnableOption "Fish Tide Theme";
    funcs.ide.enable = mkEnableOption "IDE Fish Function";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;

      plugins = mkIf cfg.tide.enable [
        { name = "tide"; src = pkgs.fishPlugins.tide.src; }
      ];

      functions = {
        ide = mkIf cfg.funcs.ide.enable ''
          ${pkgs.direnv.outPath}/bin/direnv exec $argv[1] code $argv[1..]
        '';
      };
    };
  };
}
