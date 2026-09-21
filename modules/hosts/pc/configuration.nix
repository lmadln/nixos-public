{ self, inputs, ... }: {
  flake.nixosConfigurationModules.pc = { config, pkgs, ... }: {
    imports = [
      self.nixosConfigurationModules.core
      self.nixosConfigurationModules.gui

      self.nixosUsers.alex
      self.nixosUsers.user
      self.nixosUsers.ssh
      self.nixosUsers.guest
    ] ++ (builtins.attrValues self.nixosModules);

    sys.keyd.enable = true;

    services.hardware.openrgb.enable = true;

    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE="0666", GROUP="dialout"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE="0666", GROUP="dialout"
    '';

    users.mutableUsers = false;

    networking.hostName = "pc";

    virtualisation.waydroid.enable = true;
    virtualisation.waydroid.package = pkgs.waydroid-nftables;
    networking.firewall.trustedInterfaces = [ "waydroid0" ];

    # Brightness
    hardware.i2c.enable = true;

    environment.systemPackages = [
      pkgs.ddcutil
    ];

    # Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # Btrfs specific
    zramSwap.enable = true;
    services.btrfs.autoScrub.enable = true;
    services.btrfs.autoScrub.interval = "monthly";
    ## Snapshots
    services.snapper.configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "alex" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
    };

    services.xserver.videoDrivers = [ "amdgpu" ]; # Fixes plymoth resolution

    services.openssh.enable = true;  
    services.openssh.settings.AllowUsers = [ "ssh" ];


    system.stateVersion = "25.11";
  };
}
