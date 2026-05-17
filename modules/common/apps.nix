{ self, inputs, ... }: {
  flake.nixosModules.commonApps = { config, pkgs, ... }: {
    imports = [
    ];
    
    environment.systemPackages = with pkgs; [
      spotify
      easyeffects
      atril # [.pdf, .djvu] viewer
      abiword # [.docx] editor
    ];
  };
}
