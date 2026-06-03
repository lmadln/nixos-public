{ self, inputs, ... }: {
  flake.nixosConfigurationModules.gui = { config, pkgs, ... }: {
    imports = [
      self.nixosSystemModules.boot.splash      
      self.nixosSystemModules.display
      self.nixosSystemModules.audio
      self.nixosSystemModules.fonts
    ];
  };
}
