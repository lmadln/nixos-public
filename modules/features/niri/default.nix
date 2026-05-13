{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    flakeDir = "/home/${username}/nixos";
    configsDir = "/home/${username}/nixos/modules/hosts/${config.networking.hostName}/configs/niri/";
    
    scriptContents = builtins.readFile ../../hosts/${config.networking.hostName}/configs/niri/scripts/toggle_workspace.sh;
    toggle_workspace_script = pkgs.writeShellScriptBin "toggle_workspace" scriptContents;
  in
  {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs;[
      kitty
      wl-clipboard
      wl-clip-persist
      xwayland-satellite
      
      # Printscreen utils
      grim
      slurp
      satty
      
      toggle_workspace_script
    ];

    home-manager.users."${username}" = { config, ... }: {      
      home.file.".config/niri/config.kdl".source = 
        config.lib.file.mkOutOfStoreSymlink "${configsDir}/config.kdl";
      
      home.file.".config/niri/noctalia.kdl".source = 
        config.lib.file.mkOutOfStoreSymlink "${configsDir}/noctalia.kdl";
      
      xdg.configFile."niri/conf.d".source = 
        config.lib.file.mkOutOfStoreSymlink "${configsDir}/conf.d";
    };
  };
}
