{ self, inputs, ... }: {

flake.nixosModules.pcConfiguration = { config, pkgs, ... }: {
  imports = [
    self.nixosModules.core
    self.nixosModules.base
    
    self.nixosModules.wayland
    self.nixosModules.pcWayland
    
    self.nixosModules.commonApps
    self.nixosModules.pcApps
    
    self.nixosModules.niri
    self.nixosModules.noctalia
  ];
  
  networking.hostName = "pc";
  
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

  services.openssh.enable = true;  
};
}
