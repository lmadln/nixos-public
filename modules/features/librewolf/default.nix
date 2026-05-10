{ self, inputs, ... }: {
  flake.nixosModules.librewolf = { pkgs, lib, config, ... }: {
    home-manager.users."${config.custom.username}" = { pkgs, ... }: {
      programs.librewolf = {
        enable = true;
        
        profiles.nixos = {
          isDefault = true;
          
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            darkreader
          ];
          
          settings = {
            "browser.startup.page" = 3;
            
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
