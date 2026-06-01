{ self, inputs, ... }: {
  flake.nixosModules.localsend = { pkgs, config, ... }: 
  let
    username = config.custom.username;
  in
  {
    environment.systemPackages = [ pkgs.localsend ];
    
    networking.firewall.allowedTCPPorts = [ 53317 ];
    networking.firewall.allowedUDPPorts = [ 53317 ];
  };
}
