{ self, inputs, ... }: {
  flake.nixosModules.pcApps = { config, pkgs, ... }: {
    imports = [
      self.nixosModules.firefox
      self.nixosModules.librewolf
      self.nixosModules.steam
      self.nixosModules.obs-studio
      self.nixosModules.vscode
      self.nixosModules.v2rayn
      self.nixosModules.kitty
      self.nixosModules.yazi
    ];
    
    environment.systemPackages = with pkgs; [
        godot
        bitwarden-desktop
    ];
    
    services.flatpak = {
      enable = true;
      
      remotes = [
        { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
      ];
      
      packages = [
        "com.pot_app.pot"
      ];
      
      # update.onActivation = true;
      
      uninstallUnmanaged = true; 
    };
  };
}
