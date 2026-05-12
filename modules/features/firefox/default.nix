{ self, inputs, ... }: {
  flake.nixosModules.firefox = { pkgs, lib, config, ... }: {
    nixpkgs.overlays = [ inputs.nur.overlays.default ];
    
    home-manager.users."${config.custom.username}" = { pkgs, config, ... }: {
      home.packages = with pkgs; [
        pywalfox-native
      ];
      
      home.activation.installPywalfox = config.lib.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD ${pkgs.pywalfox-native}/bin/pywalfox --browser firefox install
      '';
      
      programs.firefox = {
        enable = true;
        
        nativeMessagingHosts = with pkgs; [
          pywalfox-native
        ];
        
        profiles.nixos = {
          isDefault = true;
          
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            darkreader
            pywalfox
            bitwarden
          ];
          
          settings = {
            "extensions.autoDisableScopes" = 0;
            "extensions.enabledScopes" = 15;

            "sidebar.revamp" = true;
            "sidebar.verticalTabs" = true;
            
            "browser.startup.page" = 3;
            "browser.zoom.siteSpecific" = true;
            "identity.fxaccounts.enabled" = false;
            "privacy.resistFingerprinting" = false;
            "extensions.pocket.enabled" = false;
            "browser.tabs.firefox-view" = false;
            
            "signon.rememberSignons" = false;
            "passwordmanager.enabled" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "dom.security.https_only_mode" = true;
            "privacy.trackingprotection.enabled" = true;
            "datareporting.healthreport.uploadEnabled" = false;
            "toolkit.telemetry.enabled" = false;
            "geo.enabled" = false;
            
            "network.proxy.type" = 1;
            "network.proxy.socks" = "127.0.0.1";
            "network.proxy.socks_port" = 10808;
            "network.proxy.socks_remote_dns" = true;
          };
          
          search = {
            force = true;
            default = "ddg";
            engines = {
              "Nix Packages" = {
                urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
                icon = "https://nixos.wiki/favicon.png";
                definedAliases = [ "@np" ];
              };
              "bing".metaData.hidden = true;
              "google".metaData.hidden = true;
            };
          };
        };
      };
    };
  };
}
