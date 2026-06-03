{ self, inputs, ... }: {
  flake.nixosConfigurationModules.pc = { config, pkgs, ... }: {
    imports = [
      self.nixosUsers.alex
      self.nixosUsers.user
      self.nixosUsers.guest
    ] ++ (builtins.attrValues self.nixosModules);

    sys.keyd.enable = true;

    users.mutableUsers = false;

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

    services.xserver.videoDrivers = [ "amdgpu" ]; # Fixes plymoth resolution

    services.openssh.enable = true;  
    services.openssh.settings.AllowUsers = [ "alex" ];
  };
}
