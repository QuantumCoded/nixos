{ lib, ... }:
let
  inherit (builtins)
    attrValues
    ;

  inherit (lib)
    filterAttrs
    ;
in
modules: attrValues (filterAttrs (k: _: k != "default") modules)

