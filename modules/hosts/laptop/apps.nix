{ self, inputs, ... }: {
  flake.nixosModules.laptopApps = { config, pkgs, ... }: {
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
  };
}
