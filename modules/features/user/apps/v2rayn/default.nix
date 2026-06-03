{ self, inputs, ... }: {
  flake.nixosModules.v2rayn = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.apps.v2rayn.users;
  in {

    options.user.apps.v2rayn.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "v2rayn";
    };

    config = lib.mkIf (users != []) {

      programs.dconf.enable = true;
      
      environment.systemPackages = [
        pkgs.xray
      ];
      
      home-manager.users = lib.genAttrs users (user: {

        home.packages = [
          pkgs.v2rayn
          pkgs.v2ray-geoip
          pkgs.v2ray-domain-list-community
        ];

        xdg.dataFile = {
          "v2rayN/bin/xray/xray".source = "${pkgs.xray}/bin/xray";
          "v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
          "v2rayN/bin/geoip.dat".source = "${pkgs.v2ray-geoip}/share/v2ray/geoip.dat";
          "v2rayN/bin/geosite.dat".source = "${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat";
        };
      });
    };
  };
}
