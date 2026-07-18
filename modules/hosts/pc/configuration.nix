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

    users.mutableUsers = false;

    networking.hostName = "pc";

    # Brightness
    hardware.i2c.enable = true;

    environment.systemPackages = [
      pkgs.ddcutil
    ];

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
