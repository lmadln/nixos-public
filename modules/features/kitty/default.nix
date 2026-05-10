{ self, inputs, ... }: {
  flake.nixosModules.kitty = { pkgs, config, ... }: 
  let
    username = config.custom.username;
  in
  {
    environment.systemPackages = [ pkgs.kitty ];
    
    home-manager.users."${username}" = { config, ... }: {
      home.file.".config/kitty/kitty.conf".source = 
        config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos/modules/features/kitty/kitty.conf";
      
      #home.file.".config/kitty/colors.conf".source = 
      #  config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos/modules/features/kitty/colors.conf";
    };
  };
}
