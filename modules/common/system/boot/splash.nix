{ self, inputs, ... }: {
  flake.nixosSystemModules.boot.splash = { config, pkgs, ... }: {

    boot.plymouth = {
      enable = true;
      theme = "breeze";
    };
    
    boot.kernelParams = [ 
      "splash"
    ];
  };
}
