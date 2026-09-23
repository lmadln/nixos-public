{ self, inputs, ... }: {
  flake.nixosConfigurationModules.gui = { config, pkgs, ... }: {
    imports = [
      self.nixosSystemModules.boot.splash      
      self.nixosSystemModules.display
      self.nixosSystemModules.audio
      self.nixosSystemModules.fonts
    ];

    hardware.opentabletdriver.enable = true;

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
  };
}
