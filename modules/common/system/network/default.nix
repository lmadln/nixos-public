{ self, inputs, ... }: {
  flake.nixosSystemModules.network = { config, pkgs, ... }: {

    networking.networkmanager.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
      };
    };
  };
}
