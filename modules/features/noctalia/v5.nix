{ self, inputs, hostDir, ... }: {
  flake.nixosModules.noctalia = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    
    configsDir = "/home/${username}/nixos/modules/hosts/${config.networking.hostName}/configs/noctalia/";
  in {
    environment.systemPackages = [
      pkgs.python3
    ];
    
    home-manager.users."${username}" = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia.enable = true;
    };
  };
}
