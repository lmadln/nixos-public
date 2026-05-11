{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { pkgs, config, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.users."${config.custom.username}" = { pkgs, ... }: {
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
          "image/jpeg" = [ "imv.desktop" "feh.desktop" "librewolf.desktop" ];
          "image/png"  = [ "imv.desktop" "librewolf.desktop" ];
          
          "video/mp4"  = [ "mpv.desktop" "librewolf.desktop" ];
          "video/mkv"  = [ "mpv.desktop" "librewolf.desktop" ];
          
          "application/pdf" = [ "librewolf.desktop" ];
          
          "text/html" = [ "librewolf.desktop" ];
          "x-scheme-handler/http"  = [ "librewolf.desktop" ];
          "x-scheme-handler/https" = [ "librewolf.desktop" ];
        };
      };
    };
  };
}
