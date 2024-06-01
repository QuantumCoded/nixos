{
  base.virtualization = {
    enable = true;

    vfioPciIds = [
      # USB 3.1 Controller
      "1b21:1242"
      # GPU
      "10de:1e04"
      # GPU Audio
      "10de:10f7"
      # GPU USB 3.1 Controller
      "10de:1ad6"
      # GPU USB-C Controller
      "10de:1ad7"
    ];

    cpuArch = "intel";
    nvidiaGpu = true;
    virtCpus = "6-7";
    hostCpus = "0-7";
  };
}
