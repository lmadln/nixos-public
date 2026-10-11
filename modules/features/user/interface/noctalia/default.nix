{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, config, lib, ... }: 
  let
    users = lib.unique config.user.interface.noctalia.users;

    username = config.custom.username;
    
    # settingsFile = if (config.networking.hostName == "laptop") then ./laptop-settings.json else ./settings.json;
  in
  {
    options.user.interface.noctalia.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "noctalia";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {

        programs.noctalia = {
          enable = true;

          settings = ./noctalia-config.toml;

          systemd.enable = true;
        };

        programs.mpvpaper.enable = true;

        home.packages = [
          pkgs.python3
        ];
      
        #xdg.configFile."noctalia/settings.json".source = 
          #"${settingsFile}";
          #./settings.json;
          #config.lib.file.mkOutOfStoreSymlink "${configsDir}/settings.json";
      });
    };
  };
}
