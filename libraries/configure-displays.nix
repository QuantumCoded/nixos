{ fpkgs, ... }:
{ backend
, outputSelector ? "--output"
, layout
}:
let
  lib = fpkgs.lib;

  flattenSettings = settings: lib.concatStringsSep " "
    (lib.mapAttrsToList
      (arg: value: "--${arg} ${builtins.toString value}")
      settings);

  args = lib.concatStringsSep " "
    (lib.mapAttrsToList
      (output: settings: "${outputSelector} ${output} ${flattenSettings settings}")
      layout);
in
"${backend} ${args}"
