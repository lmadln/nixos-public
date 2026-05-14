{ self, inputs, ... }: {
  flake.nixosModules.librewolf = { pkgs, lib, config, ... }: {
    home-manager.users."${config.custom.username}" = { pkgs, ... }: {
      home.packages = with pkgs; [
        pywalfox-native
      ];
            
      programs.librewolf = {
        enable = true;
        
        nativeMessagingHosts = with pkgs; [
          pywalfox-native
        ];
        
        policies = {
          Cookies = {
            Allow =[
              "https://google.com"
              "https://accounts.google.com"
              "https://youtube.com"
              "https://telegram.org"
              "https://web.telegram.org"
            ];
          };
        };
        
        profiles.nixos = {
          isDefault = true;
          
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            darkreader
            ublock-origin
            pywalfox
            multi-account-containers
            bitwarden
          ];
          
          settings = {
            "browser.startup.page" = 3;
            
            "sidebar.revamp" = true;
            "sidebar.verticalTabs" = true;
            
            "extensions.autoDisableScopes" = 0;
            "extensions.enabledScopes" = 15;
            
            "beacon.enabled" = false;
            "device.sensors.enabled" = false;
            "dom.battery.enabled" = false;
            "dom.event.clipboardevents.enabled" = false;
            "geo.enabled" = false;
            "media.peerconnection.enabled" = false;
            "privacy.firstparty.isolate" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.socialtracking.enabled" = true;
            
            "identity.fxaccounts.enabled" = false;
            "privacy.resistFingerprinting" = false;
            "extensions.pocket.enabled" = false;
            "browser.tabs.firefox-view" = false;
            
            "signon.rememberSignons" = false;
            "passwordmanager.enabled" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "dom.security.https_only_mode" = true;
            "datareporting.healthreport.uploadEnabled" = false;
            "toolkit.telemetry.enabled" = false;
            
            "privacy.clearOnShutdown.cookies" = false;
            "network.cookie.lifetimePolicy" = 0;
            
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            
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
