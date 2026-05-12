{ self, inputs, ... }: {
  flake.nixosModules.v2rayn = { pkgs, config, ... }: 
  let
    username = config.custom.username;
  in
  {
    programs.dconf.enable = true;
    
    environment.systemPackages = with pkgs; [
      v2rayn
      xray
      v2ray-geoip
      v2ray-domain-list-community
    ];
    
    home-manager.users."${username}" = { config, ... }: {
      xdg.dataFile = {
        "v2rayN/bin/xray/xray".source = "${pkgs.xray}/bin/xray";
        "v2rayN/bin/sing_box/sing-box".source = "${pkgs.sing-box}/bin/sing-box";
        "v2rayN/bin/geoip.dat".source = "${pkgs.v2ray-geoip}/share/v2ray/geoip.dat";
        "v2rayN/bin/geosite.dat".source = "${pkgs.v2ray-domain-list-community}/share/v2ray/geosite.dat";
      };
    };
  };
}
