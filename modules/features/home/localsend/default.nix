{ self, inputs, ... }: {
  flake.nixosUserModules.localsend = { config, pkgs, lib, ... }:
  let
    cfg = config.myFeatures.localsend;
  in {
    options.myFeatures.localsend = {
      enableFor = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Enable localsend for given users";
      };
    };
    config = lib.mkIf (cfg.enableFor != []) {
      networking.firewall.allowedTCPPorts = [ 53317 ];
      networking.firewall.allowedUDPPorts = [ 53317 ];

      home-manager.users = lib.genAttrs cfg.enableFor (userName: {
        home.packages = [ pkgs.localsend ];
      });
    };
  };
}
