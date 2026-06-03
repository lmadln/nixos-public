{ self, inputs, ... }: {
  flake.nixosSystemModules.display = { config, pkgs, ... }: {

    services.displayManager = {
      ly.enable = true;
      defaultSession = "niri";
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        rocmPackages.clr
      ];
    };

    programs.xwayland.enable = true;
    programs.dconf.enable = true;

    environment.systemPackages = with pkgs; [
      libnotify
      brightnessctl
    ];
  };
}
