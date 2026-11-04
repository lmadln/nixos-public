{ self, inputs, ... }: {
  flake.nixosModules.happ = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.apps.happ.users;
    happPkg = pkgs.callPackage ./_src/default.nix { };
  in {

    options.user.apps.happ.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "happ";
    };

    config = lib.mkIf (users != []) {

      boot.kernelModules = [ "tun" ];
      networking.firewall.checkReversePath = "loose";
      networking.firewall.trustedInterfaces = [ "tun0" ];

      systemd.services.happd = {
        description = "Happ TUN Client Daemon";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${happPkg}/opt/happ/bin/happd";
          Restart = "on-failure";
          RestartSec = "5s";
          KillMode = "mixed";
          KillSignal = "SIGTERM";
        };
      };

      home-manager.users = lib.genAttrs users (user: {

        home.packages = [
          happPkg
        ];
      });
    };
  };
}
