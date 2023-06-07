{ config, ... }:
let
  userName = "QuantumCoded";
in
{
  programs.git = {
    enable = true;

    inherit userName;
    userEmail = "${userName}@users.noreply.github.com";

    signing.key = config.home.homeDirectory + "/.ssh/id_ed25519";
    signing.signByDefault = true;

    aliases = {
      oops = "reset --soft HEAD~1";
      trash = "reset --hard HEAD";
    };

    extraConfig = {
      gpg.format = "ssh";
      pull.rebase = false;
    };
  };
}
