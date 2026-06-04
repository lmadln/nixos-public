{ self, inputs, ... }: {
  flake.nixosModules.imv = { config, pkgs, lib, ... }:
  let
    users = lib.unique config.user.apps.imv.users;
  in {
    options.user.apps.imv.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Imv image viewer";
    };
    config = lib.mkIf (users != []) {
      home-manager.users = lib.genAttrs users (user: {
        programs.imv = {
          enable = true;

          settings = {
            options = {
              background = "checks"; 

              fullscreen = false;
              loop_input = true;
              scaling_mode = "shrink";

              overlay = true;
            };
          };
        };
      });
    };
  };
}
