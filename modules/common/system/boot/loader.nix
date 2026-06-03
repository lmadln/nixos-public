{ self, inputs, ... }: {
  flake.nixosSystemModules.boot.loader = { config, pkgs, ... }: {

    boot.loader.systemd-boot.enable = true;         
    boot.loader.timeout = 15;

    boot.kernelParams = [ 
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;
  };
}
