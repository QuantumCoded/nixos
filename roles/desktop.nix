{
  base.virtualization = {
    enable = true;

    vfioPciIds = [
      # USB 3.1 Controller
      "1b21:1242"
      # Ethernet Controller
      "8086:15b8"
    ];

    vfioBusIds = [
      # Nvidia GPU
      "07:00.0"
      "07:00.1"
    ];

    cpuArch = "intel";
    nvidiaGpu = true;
    virtCpus = "6-7";
    hostCpus = "0-7";
  };
}
