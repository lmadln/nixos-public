{ self, inputs, ... }: {
  flake.nixosModules.localsend = { config, pkgs, lib, ... }:
  let
    users = lib.unique config.user.apps.localsend.users;
  in {
    options.user.apps.localsend.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Localsend";
    };
    config = lib.mkIf (users != []) {
      networking.firewall.allowedTCPPorts = [ 53317 ];
      networking.firewall.allowedUDPPorts = [ 53317 ];

      home-manager.users = lib.genAttrs users (user: {
        home.packages = [ pkgs.localsend ];
      });
    };
  };
}
