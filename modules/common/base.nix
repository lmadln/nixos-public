{ self, inputs, ... }: {
  flake.nixosModules.base = { config, pkgs, ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
