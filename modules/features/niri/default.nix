{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    flakeDir = "/home/${username}/nixos";
    
    scriptContents = builtins.readFile ./scripts/toggle_workspace.sh;
    toggle_workspace_script = pkgs.writeShellScriptBin "toggle_workspace" scriptContents;
  in
  {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs;[
      kitty
      wl-clipboard
      xwayland-satellite
      
      toggle_workspace_script
    ];

    home-manager.users."${username}" = { config, ... }: {      
      home.file.".config/niri/config.kdl".source = 
        config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/features/niri/config.kdl";
      
      home.file.".config/niri/noctalia.kdl".source = 
        config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/features/niri/noctalia.kdl";
      
      xdg.configFile."niri/conf.d".source = 
        config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/features/niri/conf.d";
    };
  };
}
