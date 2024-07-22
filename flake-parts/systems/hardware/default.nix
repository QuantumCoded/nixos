{
  flake.hardwareModules = {
    avalon = import ./avalon;
    hydrogen = import ./hydrogen;
    odyssey = import ./odyssey;
    quantum = import ./quantum;
  };
}
