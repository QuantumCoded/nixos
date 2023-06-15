let
  defaultAliases = {
    oops = "reset --soft HEAD~1";
    trash = "reset --hard HEAD";
  };
in
{ userName
, userEmail ? "${userName}@users.noreply.github.com"
, aliases ? defaultAliases
}:
{ config, ... }:

{
  programs.git = {
    inherit aliases userEmail userName;

    enable = true;

    # TODO: this needs some logic to allow custom directories or fail an assert with a
    # "you can set the homeDir" option in the wrapper attributes.
    signing.key = config.home.homeDirectory + "/.ssh/id_ed25519";
    signing.signByDefault = true;

    extraConfig = {
      gpg.format = "ssh";
      pull.rebase = false;
    };
  };
}
