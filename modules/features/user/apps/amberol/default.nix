{ self, inputs, ... }: {
  flake.nixosModules.amberol = { config, pkgs, lib, ... }:
  let
    users = lib.unique config.user.apps.amberol.users;
  in {
    options.user.apps.amberol.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Amberol music player";
    };
    config = lib.mkIf (users != []) {
      home-manager.users = lib.genAttrs users (user: {
        servoces.ambrol.enable = true;
      });
    };
  };
}
