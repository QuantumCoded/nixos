{ fpkgs, ... }:

list: fpkgs.lib.zipListsWith
  (idx: val: { inherit idx val; })
  (builtins.genList (x: x + 1) (builtins.length list))
  list
