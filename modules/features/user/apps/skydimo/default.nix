{ self, inputs, ... }:
let
  module = "skydimo";
in {
  flake.nixosModules.${module} = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.apps.${module}.users;
    skydimoPkg = pkgs.callPackage ./_src/default.nix { };
  in {

    options.user.apps.${module}.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "skydimo";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {

        home.packages = [
          skydimoPkg
        ];
      });
    };
  };
}
