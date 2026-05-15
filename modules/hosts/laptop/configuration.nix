{ self, inputs, hostDir, ... }: {

flake.nixosModules.laptopConfiguration = { config, pkgs, ... }: {
  imports = [
    self.nixosModules.core
    self.nixosModules.base
    
    self.nixosModules.wayland
    self.nixosModules.commonApps
    self.nixosModules.laptopApps
    
    self.nixosModules.niri
    self.nixosModules.noctalia
  ];
  
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
  
};
}
