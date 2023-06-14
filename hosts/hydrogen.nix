{ inputs, ... } @ specialArgs:

inputs.nixpkgs.lib.nixosSystem {
  inherit specialArgs;

  system = "x86_64-linux";

  modules = [
    ({ pkgs, ... }:
      let
        userName = "jeff";
      in
      {
        imports = [
          # Bootloader
          (import ../base/host/boot/efi.nix { })
          (import ../base/host/boot/systemd-boot.nix { })

          # System Environment
          (import ../base/host/environment/shells.nix { shells = [ "fish" ]; })
          (import ../base/host/environment/system-packages.nix { })

          # Filesystems
          (import ../base/host/filesystems/host.nix { })

          # Networking
          # TODO: remove wireless before deploying
          (import ../base/host/networking/connections/wireless.nix { })
          (import ../base/host/networking/networkmanager.nix { })

          # Nix
          (import ../base/host/nix/flakes.nix { })
          (import ../base/host/nix/registry.nix { })

          # Services
          (import ../base/host/services/ssh.nix { })

          # Users
          (import ../base/host/users/user.nix { inherit userName; })

          # Home Manager
          (import ../base/host/home-manager.nix {
            inherit userName;
            modules = [ ../home/jeff/hydrogen.nix ];
          })

          # Locale
          (import ../base/host/locale.nix { })

          # Nixpkgs
          (import ../base/host/nixpkgs.nix { })

          # Overlays
          (import ../base/overlays.nix { })
        ];

        # Host Name
        networking.hostName = "hydrogen";

        # System State
        system.stateVersion = "23.05";
      })
  ];
}
