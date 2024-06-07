{ cell, inputs }:
let
  inherit (inputs.std.lib.dev) mkShell;
in
{
  default = mkShell {
    name = "Default";

    packages = with inputs.nixpkgs; [
      inputs.agenix.packages.default
      attic-client
      deploy-rs
      nixpkgs-fmt
      git-lfs
    ];

    commands = [
      {
        name = "fmt";
        command = "nixpkgs-fmt .";
        help = "runs nixpkgs-fmt .";
      }
      {
        name = "nvim";
        command = "nix run --refresh github:quantumcoded/neovim";
        help = "runs latest neovim from github";
      }
    ];

    devshell.startup.binary-cache-key.text = ''
      export LOCAL_KEY=/etc/nixos/keys/binary-cache-key.pem
    '';
  };
}
