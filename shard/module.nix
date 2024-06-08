args @ { config, lib, options, inputs, ... }:
let
  inherit (builtins)
    elem
    filter
    mapAttrs
    ;

  inherit (lib)
    attrByPath
    filterAttrs
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.shard;
in
{
  options = {
    shard = {
      enable = mkEnableOption "shard";

      source = mkOption {
        type = types.path;
        description = "The path to a folder containing Shards.";
      };

      apply = mkOption {
        type = with types; listOf (listOf str);
        default = [ ];
      };

      extract = mkOption {
        type = with types; listOf (listOf str);
        default = [ ];
      };

      extractWithSystem = mkOption {
        type = with types; listOf (listOf str);
        default = [ ];
      };
    };
  };

  config =
    let
      applyModule = { src, ... }: mkMerge
        (filter (x: x != null)
          (map (path: attrByPath path null src) cfg.apply));

      extractModule = { src, ... }: {
        flake = mkMerge
          (filter (x: x != null)
            (map (path: attrByPath path null src) cfg.extract));
      };

      # TODO: finish this
      extractWithSystemModule = { config, src, ... }: {

      };
    in
    mkIf cfg.enable {
      # WARN: this is read-only in extendFlake scope! trying to modify this
      # attribute causes infinite recurion or stack overflow errors. this
      # can be used only for passing read-only values into extendFlake scope.
      flake.__shard = {
        inherit args;
        inherit (cfg) source;
        modules = [
          applyModule
          extractModule
        ];
      };
    };
}
