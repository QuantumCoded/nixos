{ config, lib, pkgs, ... }:

{
  age.secrets.attic-local-token.file = ./secrets/attic-local-token.age;

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
    substituters = lib.mkForce [
      "http://attic.hydrogen.lan/local"
      "https://cache.nixos.org/"
    ];

    trusted-public-keys = lib.mkForce [
      "local:WfrRqzAL225DVcxg5tug9FtVX+gH6kkjcj3hGerZmq0="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  systemd.services.attic-store-watcher = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      User = "root";
      Group = "root";
      EnvironmentFile = config.age.secrets.attic-local-token.path;
    };
    script = ''
      ${pkgs.attic-client}/bin/attic login hydrogen http://attic.hydrogen.lan/ $ATTIC_TOKEN
      ${pkgs.attic-client}/bin/attic watch-store local
    '';
  };
}
