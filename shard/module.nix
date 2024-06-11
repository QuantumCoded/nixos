args @ { config, flake-parts-lib, lib, ... }:
let
  inherit (flake-parts-lib)
    mkTransposedPerSystemModule
    ;

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

  imports = [
    (mkTransposedPerSystemModule {
      file = ./.;
      name = "__shardPerSystem";
      option = mkOption {
        type = with types; attrsOf (lazyAttrsOf anything);
        default = { };
      };
    })
  ];

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

      extractWithSystemModule = { src, ... }: {
        imports = [
          # make the transposition module
        ];
      };
    in
    mkIf cfg.enable {
      # WARN: this is read-only in any other scope! trying to modify this
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

      perSystem = { pkgs, ... }: {
        __shardPerSystem = { inherit pkgs; };
      };
    };
}
