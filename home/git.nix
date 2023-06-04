{ config, ... }:
let
  userName = "QuantumCoded";
in
{
  programs.git = {
    inherit userName;
    enable = true;
    userEmail = "${userName}@users.noreply.github.com";
    signing.key = config.home.homeDirectory + "/.ssh/id_ed25519";
    signing.signByDefault = true;
    extraConfig = {
      gpg.format = "ssh";
      pull.rebase = false;
    };
  };
}
