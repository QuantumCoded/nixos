{ lib, ... }:
let
  inherit (lib)
    attrValues
    filterAttrs
    ;
in
modules: attrValues (filterAttrs (k: _: k != "default") modules)

