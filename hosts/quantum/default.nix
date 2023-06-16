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
          (import ../../base/host/boot/efi.nix { })
          (import ../../base/host/boot/systemd-boot.nix { })

          # System Environment
          (import ../../base/host/environment/shells.nix { shells = [ "fish" ]; })
          (import ../../base/host/environment/system-packages.nix { })

          # Filesystems
          (import ../../base/host/filesystems/home.nix { })
          (import ../../base/host/filesystems/host.nix { })
          (import ../../base/host/filesystems/nfs.nix {
            device = "docker.vmlan:/data";
            mount = "/nfs/hydrogen";
          })
          (import ../../base/host/filesystems/nix-store.nix { })
          (import ../../base/host/filesystems/var.nix { })

          # Fonts
          (import ../../base/host/fonts/nerdfonts.nix { })

          # Hardware
          (import ../../base/host/hardware/opengl.nix { package = pkgs.raccoon.kitty; })

          # Host Hardware
          ./hardware.nix

          # Networking
          (import ../../base/host/networking/connections/wireless.nix { })
          (import ../../base/host/networking/networkmanager.nix { })

          # Nix
          (import ../../base/host/nix/flakes.nix { })
          (import ../../base/host/nix/registry.nix { })

          # Security
          (import ../../base/host/security/noisetorch.nix { })

          # X11
          (import ../../base/host/services/xserver/bspwm.nix { })
          (import ../../base/host/services/xserver/nvidia.nix { })
          (import ../../base/host/services/xserver/plasma.nix { })
          (import ../../base/host/services/xserver/x11.nix { })

          # Services
          (import ../../base/host/services/cups.nix { })
          (import ../../base/host/services/pipewire.nix { })
          (import ../../base/host/services/ssh.nix { })

          # Users
          (import ../../base/host/users/user.nix { inherit userName; })

          # Home Manager
          (import ../../base/host/home-manager.nix {
            inherit userName;
            modules = [ ../../home/jeff/quantum.nix ];
          })

          # Locale
          (import ../../base/host/locale.nix { })

          # Nixpkgs
          (import ../../base/host/nixpkgs.nix { })

          # Overlays
          (import ../../base/overlays.nix { })
        ];

        # Host Name
        networking.hostName = "quantum";

        # System State
        system.stateVersion = "23.05";
      })
  ];
}
