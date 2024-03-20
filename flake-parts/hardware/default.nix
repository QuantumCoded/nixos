_: { config, lib, ... }:

{
  flake.hardwareModules = {
    hydrogen = import ./hydrogen;
    odyssey = import ./odyssey;
    quantum = import ./quantum;
  };
}
