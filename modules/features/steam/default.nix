{ self, inputs, ... }: {
  flake.nixosModules.steam = { pkgs, config, ... }: {
    # nixpkgs.config.allowUnfree = true;
    
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
}
