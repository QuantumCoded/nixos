{ lib, ... }:
let
  inherit (lib)
    filterAttrs
    flatten
    mapAttrsToList
    pipe
    ;

  inherit (builtins)
    attrNames
    readDir
    ;
in
{
  # automagically import every module
  imports = pipe ./. [
    readDir
    (filterAttrs (name: kind: name != "default.nix"))
    (mapAttrsToList (name: kind:
      let
        path = ./. + "/${name}";
      in
      if kind == "directory"
      then
        pipe path [
          readDir
          attrNames
          (map (name: path + "/${name}"))
        ]
      else path
    ))
    flatten
  ];
}
