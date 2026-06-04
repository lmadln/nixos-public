{ self, inputs, ... }: {
  flake.nixosConfigurationModules.core = { config, pkgs, ... }: {
    imports = [
      self.nixosSystemModules.boot.loader
      self.nixosSystemModules.locale
      self.nixosSystemModules.network
      self.nixosSystemModules.security
      self.nixosSystemModules.storage

      self.nixosUsers.root
    ];
  
    environment.systemPackages = with pkgs; [
      killall
      btop
      wget
      git
      vim
      jq
      usbutils
      sops
    ];
  
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    nix.settings.trusted-users =[ "root" "@wheel" ];


    
    #system.stateVersion = "25.11";
  };
}
