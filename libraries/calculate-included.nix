{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;
in
{ default
, exclude ? [ ]
, include ? null
}:

lib.subtractLists
  exclude
  (if include == null
  then default
  else include)
