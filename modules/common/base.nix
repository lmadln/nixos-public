{ self, inputs, ... }: {
  flake.nixosModules.base = { config, pkgs, ... }: {
    home-manager.users."${config.custom.username}" = { pkgs, ... }: {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
