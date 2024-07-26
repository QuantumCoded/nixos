{
  config.flake.userModules = {
    dad = import ./dad.nix;
    jeff = import ./jeff.nix;
  };
}
