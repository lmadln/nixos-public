{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, config, lib, ... }: 
  let
    users = lib.unique config.user.interface.noctalia.users;

    username = config.custom.username;
    
    #configsDir = "/home/${username}/nixos/modules/hosts/${config.networking.hostName}/configs/noctalia/";

    settingsFile = if (config.networking.hostName == "laptop") then ./laptop-settings.json else ./settings.json;
    
    custom-noctalia = pkgs.noctalia-shell.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++[
        ./color-tweak.patch
        #../../hosts/${config.networking.hostName}/configs/noctalia/color-tweak.patch
      ];
    });
  in
  {

    options.user.interface.noctalia.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "noctalia";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {

        home.packages = [
          custom-noctalia
          pkgs.python3
        ];
      
        xdg.configFile."noctalia/settings.json".source = 
          "${settingsFile}";
          #./settings.json;
          #config.lib.file.mkOutOfStoreSymlink "${configsDir}/settings.json";
      });
    };
  };
}
