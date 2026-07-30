{ self, inputs, ... }: {
  flake.nixosModules.cursors-vimix = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.interface.cursors.vimix.users;
  in {
    options.user.interface.cursors.vimix.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Vimix cursor";
    };
    config = lib.mkIf (users != []) {
      home-manager.users = lib.genAttrs users (user: {
        home.pointerCursor = {
          enable = true;
          name = "Vimix-cursors";
          package = pkgs.vimix-cursors;
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      });
    };
  };
}
