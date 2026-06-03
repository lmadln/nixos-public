{ self, inputs, ... }: {
  flake.nixosModules.steam = { pkgs, config, lib, ... }: 
  let
    cfg = config.sys.steam; 
  in {

    options.sys.steam = {
      enable = lib.mkEnableOption "Steam";
    };

    config = lib.mkIf cfg.enable {

      nixpkgs.config.allowUnfree = true;
      
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true; 
      };
      
      programs.gamemode = {
        enable = true;
        settings = {
          general = {
            renice = 10;
          };
        };
      };
    };
  };
}
