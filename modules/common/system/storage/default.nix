{ self, inputs, ... }: {
  flake.nixosSystemModules.storage = { config, pkgs, ... }: {

    nix.settings.auto-optimise-store = true;

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
    };

    services.fstrim.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;
  };
}
