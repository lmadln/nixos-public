{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    flakeDir = "/home/${username}/nixos";
  in
  {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs;[
      kitty
      wl-clipboard
      xwayland-satellite
    ];

    home-manager.users."${username}" = { config, ... }: {      
      home.file.".config/niri/config.kdl".source = 
        config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/features/niri/config.kdl";
      
      xdg.configFile."niri/conf.d".source = 
        config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/features/niri/conf.d";
    };
  };
}
