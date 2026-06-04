{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { pkgs, config, lib, ... }:
  let
    users = lib.unique config.user.home-manager.users;
  in {
    options.user.home-manager.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Home-manager default configuration";
    };

    config = lib.mkIf (users != []) {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    
      home-manager.backupFileExtension = "backup";

      home-manager.users = lib.genAttrs users (user: {
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
            "image/jpeg" = [ "imv.desktop" "librewolf.desktop" "firefox.desktop" ];
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
