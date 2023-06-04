{ ... }:
let
  userName = "QuantumCoded";
in
{
  programs.git = {
    inherit userName;
    enable = true;
    userEmail = "${userName}@users.noreply.github.com";
    extraConfig.pull.rebase = false;
  };
}
