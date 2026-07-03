{ self, inputs, ... }: {
  flake.nixosModules.prismlauncher = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.apps.prismlauncher.users;
  in {

    options.user.apps.prismlauncher.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "prismlauncher";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {

        programs.prismlauncher.enable = true;

        home.packages = [
        ];
      });
    };
  };
}
