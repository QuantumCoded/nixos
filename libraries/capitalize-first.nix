{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;
in
string:
let
  length = builtins.stringLength string;
  capitalFirstLetter =
    lib.pipe string [
      (builtins.substring 0 1)
      lib.toUpper
    ];
  baseString = builtins.substring 1 (length - 1) string;
in
  lib.concatStrings [
    capitalFirstLetter
    baseString
  ]
