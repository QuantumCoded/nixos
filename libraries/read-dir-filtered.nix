{ fpkgs, ... }:
let
  lib = fpkgs.lib;
in
{ exclude ? [ ], path ? ./. }: lib.pipe path [
  builtins.readDir
  builtins.attrNames
  (builtins.filter (name: !(builtins.elem name exclude)))
]
