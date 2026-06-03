{ self, inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, config, lib, ... }: 
  let
    cfg = config.sys.flatpak; 
  in {
    options.sys.flatpak = {
      enable = lib.mkEnableOption "Flatpak";
      packages = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Flatpak packages";
      };
    };

    config = lib.mkIf cfg.enable {
      services.flatpak = {
        enable = true;
      
        remotes = [
          { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
        ];

        #packages = [
        #  "com.pot_app.pot"
        #];

        packages = cfg.packages;

        # update.onActivation = true;
        update.auto.enable = true; 
      
        uninstallUnmanaged = true; 
      };
    };
  };
}
