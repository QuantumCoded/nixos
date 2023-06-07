{ ... }:
let
  getModules = { exclude ? [ ], path ? ./. }:
    map (name: path + "/${name}") (
      builtins.filter
        (name: !(builtins.elem name exclude))
        (builtins.attrNames (builtins.readDir path))
    );
in
{
  imports = getModules { exclude = [ "default.nix" ]; };
}