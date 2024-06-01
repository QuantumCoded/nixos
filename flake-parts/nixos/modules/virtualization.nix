{ config, lib, pkgs, ... }:
let
  inherit (builtins)
    concatStringsSep
    ;

  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  qemuHook = pkgs.writeScript "qemu-hook.sh" ''
    #!/run/current-system/sw/bin/bash

    if [[ $2 == "start" || $2 == "stopped" ]]
    then
      if [[ $2 == "start" ]]
      then
        systemctl set-property --runtime -- user.slice AllowedCPUs=${cfg.virtCpus}
        systemctl set-property --runtime -- system.slice AllowedCPUs=${cfg.virtCpus}
        systemctl set-property --runtime -- init.scope AllowedCPUs=${cfg.virtCpus}
      else
        systemctl set-property --runtime -- user.slice AllowedCPUs=${cfg.hostCpus}
        systemctl set-property --runtime -- system.slice AllowedCPUs=${cfg.hostCpus}
        systemctl set-property --runtime -- init.scope AllowedCPUs=${cfg.hostCpus}
      fi
    fi
  '';

  cfg = config.base.virtualization;
in
{
  options.base.virtualization = {
    enable = mkEnableOption "Virtualization";

    vfioPciIds = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

    vfioBusIds = mkOption {
      type = with types; listOf str;
      default = [ ];
    };

    cpuArch = mkOption { type = types.enum [ "intel" "amd" ]; };
    nvidiaGpu = mkOption { type = types.bool; };

    virtCpus = mkOption { type = types.str; };
    hostCpus = mkOption { type = types.str; };

    acsPatch = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    virtualisation = {
      spiceUSBRedirection.enable = true;
      libvirtd.enable = true;
    };

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 jeff kvm -"
      "L+ /var/lib/libvirt/hooks/qemu - - - - ${qemuHook}"
    ];

    programs.dconf.enable = true; # virt-manager requires dconf to remember settings

    environment.systemPackages = with pkgs; [
      virt-manager
      looking-glass-client
    ];

    boot = {
      kernelParams = [
        "${cfg.cpuArch}_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=${concatStringsSep "," cfg.vfioPciIds}"
        (mkIf cfg.acsPatch "pcie_acs_override=downstream,multifunction")
      ];

      kernelModules = [
        "kvm-${cfg.cpuArch}"
      ];

      initrd = {
        extraFiles = {
          "/usr/local/bin/vfio-pci-override.sh".source = pkgs.writeScript "vfio-pci-override.sh" ''
            #! /bin/sh

            DEVS="${concatStringsSep " " (map (id: "0000:${id}") cfg.vfioBusIds)}"

            if [ ! -z "$(ls -A /sys/class/iommu)" ]; then
                for DEV in $DEVS; do
                    echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
                done
            fi

            modprobe -i vfio-pci
          '';
        };

        kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
        ] ++ (
          if cfg.nvidiaGpu then [
            "nvidia"
            "nvidia_modeset"
            "nvidia_uvm"
            "nvidia_drm"
          ] else [ ]
        );
      };

      extraModprobeConfig = ''
        install vfio-pci /usr/local/bin/vfio-pci-override.sh
      '';
    };
  };
}

