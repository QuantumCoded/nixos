{
  # documentation.nixos = {
  #   includeAllModules = true;
  #   options.warningsAreErrors = false;
  # };

  programs.ssh.knownHosts = {
    hydrogen = {
      extraHostNames = [ "hydrogen.lan" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOibBFyzpvrT7Q1F1kywc2gIOsog8HdVSUl5IXa1aHQs";
    };
  };

  nix.settings = {
    substituters = [
      "http://attic.hydrogen.lan/local"
    ];

    trusted-public-keys = [
      "local:WfrRqzAL225DVcxg5tug9FtVX+gH6kkjcj3hGerZmq0="
    ];
  };
}
