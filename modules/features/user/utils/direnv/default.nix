{ self, inputs, ... }: {
  flake.nixosModules.direnv = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.utils.direnv.users;
  in {
    options.user.utils.direnv.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Direnv";
    };
    config = lib.mkIf (users != []) {
      home-manager.users = lib.genAttrs users (user: {
        programs.direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
      });
    };
  };
}
