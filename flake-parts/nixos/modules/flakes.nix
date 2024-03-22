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
    nix.package = pkgs.unstable.nixVersions.nix_2_21;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.registry = builtins.mapAttrs (_: flake: { inherit flake; }) inputs;
  };
}
