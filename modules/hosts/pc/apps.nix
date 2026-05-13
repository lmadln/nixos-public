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
        spotify
        godot
        bitwarden-desktop
    ];
  };
}
