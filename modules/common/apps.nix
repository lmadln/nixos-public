{ self, inputs, ... }: {
  flake.nixosModules.commonApps = { config, pkgs, ... }: {
    imports = [
    ];
    
    environment.systemPackages = with pkgs; [
      abiword
    ];
  };
}
