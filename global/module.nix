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

  config = {
    # WARN: this is read-only in any other scope! trying to modify this
    # attribute causes infinite recurion or stack overflow errors. this
    # can be used only for passing read-only values into extendFlake scope.
    flake.__global = {
      inherit args;
      inherit (cfg) source;
      module = { flake.woohoo = "yippie!"; };
    };
  };
}
