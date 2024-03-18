{ ... }:

{
  home = rec {
    username = "jeff";
    homeDirectory = "/home/${username}";
    stateVersion = "23.05";
  };
}
