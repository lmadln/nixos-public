{ self, inputs, hostDir, ... }: {
  flake.nixosModules.noctalia = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    
    configsDir = "/home/${username}/nixos/modules/hosts/${config.networking.hostName}/configs/noctalia/";
    
    custom-noctalia = pkgs.noctalia-shell.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++[
        ../../hosts/${config.networking.hostName}/configs/noctalia/color-tweak.patch
      ];
    });
  in
  {
    environment.systemPackages = [
      custom-noctalia
      pkgs.python3
    ];
    
    home-manager.users."${username}" = { config, ... }: {
      home.file.".config/noctalia/settings.json".source = 
        config.lib.file.mkOutOfStoreSymlink "${configsDir}/settings.json";
    };
  };
}
