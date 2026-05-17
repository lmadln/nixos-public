{ self, inputs, ... }: {
  flake.nixosModules.commonApps = { config, pkgs, ... }: {
    imports = [
      self.nixosModules.localsend
    ];
    
    environment.systemPackages = with pkgs; [
      spotify
      easyeffects
      atril # [.pdf, .djvu] viewer
      abiword # [.docx] editor
    ];
  };
}
