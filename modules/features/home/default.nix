{ self, inputs, ... }: {
  flake.nixosUserModules.home-manager = { pkgs, config, lib, ... }:
  let
    cfg = config.myFeatures.home-manager;
  in {
    options.myFeatures.home-manager = {
      enableFor = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Enable home-manager for given users";
      };
    };

    config = lib.mkIf (cfg.enableFor != []) {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    
      home-manager.backupFileExtension = "backup";

      #home-manager.users."${username}" = { pkgs, ... }: {
      home-manager.users = lib.genAttrs cfg.enableFor (userName: {
        home.stateVersion = "26.05";

        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };

        gtk = {
          enable = true;
          theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
          };
          iconTheme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
          };
        };

        qt = {
          enable = true;
          platformTheme.name = "adwaita";
          style.name = "adwaita-dark";
        };
      
        xdg.mimeApps = {
          enable = true;
         
          defaultApplications = {
            "image/jpeg" = [ "imv.desktop" "feh.desktop" "librewolf.desktop" "firefox.desktop" ];
            "image/png"  = [ "imv.desktop" "librewolf.desktop" "firefox.desktop" ];
          
            "video/mp4"  = [ "mpv.desktop" "librewolf.desktop" "firefox.desktop" ];
            "video/mkv"  = [ "mpv.desktop" "librewolf.desktop" "firefox.desktop" ];
          
            "application/pdf" = [ "atril.desktop" "librewolf.desktop" "firefox.desktop" ];
          
            "text/html" = [ "librewolf.desktop" "firefox.desktop" ];
            "x-scheme-handler/http"  = [ "librewolf.desktop" "firefox.desktop" ];
            "x-scheme-handler/https" = [ "librewolf.desktop" "firefox.desktop" ];
          };
        };
      });
    };
  };
}
