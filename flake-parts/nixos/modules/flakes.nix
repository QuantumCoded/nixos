{ config, inputs, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.base.flakes;
in
{
  options.base.flakes = {
    enable = mkEnableOption "Flakes";
  };

  config = mkIf cfg.enable {
    nix = {
      package = pkgs.unstable.nixVersions.nix_2_21;
      settings.experimental-features = [ "nix-command" "flakes" ];
      registry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
    };
  };
}
