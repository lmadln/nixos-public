{ self, inputs, ... }: {
  flake.nixosModules.firefox = { pkgs, lib, config, ... }: {
    nixpkgs.overlays = [ inputs.nur.overlays.default ];

    home-manager.users."${config.custom.username}" = { pkgs, ... }: {
      programs.firefox = {
        enable = true;
        
        profiles.nixos = {
          isDefault = true;
          
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            darkreader
          ];
          
          settings = {
            "extensions.autoDisableScopes" = 0;
            "extensions.enabledScopes" = 15;
            
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
