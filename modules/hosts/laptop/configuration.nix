{ self, inputs, ... }: {
  flake.nixosConfiguration.laptop = { config, pkgs, ... }: {
    imports = [
      self.nixosConfigurationModules.core
      self.nixosConfigurationModules.gui

      self.nixosUsers.alex
      self.nixosUsers.user
      self.nixosUsers.guest
    ];

    sys.keyd.enable = true;

    users.mutableUsers = false;

    networking.hostName = "laptop";

    # laptop stuff  
    services.upower.enable = true;
    services.acpid.enable = true;
    services.power-profiles-daemon.enable = true;

    # Misc laptop stuff
    hardware.enableRedistributableFirmware = true;
    services.fwupd.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    services.thermald.enable = true;

    services.openssh.enable = true;
    services.openssh.settings.AllowUsers = [ "alex" ];
  };
}
