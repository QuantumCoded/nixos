{
  flake.hardwareModules = {
    avalon = import ./avalon;
    dad = import ./dad;
    hydrogen = import ./hydrogen;
    odyssey = import ./odyssey;
    quantum = import ./quantum;
  };
}
