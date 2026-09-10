{ self, inputs, ... }: {
  flake.nixosModules.firefox = { pkgs, lib, config, ... }:
  let
    users = lib.unique config.user.apps.firefox.users;
  in {
    options.user.apps.firefox.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Firefox browser";
    };

    config = lib.mkIf (users != []) {
      nixpkgs.overlays = [ inputs.nur.overlays.default ];
      
      home-manager.users = lib.genAttrs users (user: {
        home.packages = with pkgs; [
          pywalfox-native
        ];
        
        programs.firefox = {
          enable = true;
          
          nativeMessagingHosts = with pkgs; [
            pywalfox-native
          ];
          
          profiles.nixos = {
            id = 0;
            isDefault = true;
            
            extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              darkreader
              pywalfox
              bitwarden
            ];

            userChrome = ''
              menupopup, panel {
                --panel-background: rgba(50, 50, 50, 0.75) !important;
                --panel-border-color: rgba(255, 255, 255, 0.1) !important;
                --panel-shadow-margin: 0px !important;
                --panel-shadow: none !important;
                --panel-padding: 0px !important;
                
                padding: 0 !important;
                margin: 0 !important;
                border: none !important;
              }

              .menupopup-arrowscrollbox {
                background-color: var(--panel-background) !important;
                box-shadow: none !important;
                border: 1px solid var(--panel-border-color) !important;
                border-radius: 10px !important;
                
                width: 100% !important;
                min-width: 100% !important;
                box-sizing: border-box !important;
                
                margin: 0 !important;
                padding: 4px 0 !important;
              }

              menupopup scrollbox,
              .menupopup-arrowscrollbox > scrollbox {
                scrollbar-width: none !important;
                padding-inline-end: 0 !important;
                margin-inline-end: 0 !important;
              }

              #context-navigation {
                padding-inline: 0 !important;
                margin-inline: 0 !important;
              }



              .panel-arrowbox {
                display: none !important;
              }

              :is(panel, menupopup)[type="arrow"] {
                --panel-shadow-margin: 0px !important;
                --arrowpanel-margin: 0px !important;
                --arrowpanel-padding: 0px !important;
                --panel-shadow: none !important;
              }

              .panel-arrowcontainer,
              .panel-arrowcontent,
              .panel-arrowbox + slot,
              slot[part="content"],
              panel[type="arrow"]::part(content) {
                width: 100% !important;
                min-width: 100% !important;
                box-sizing: border-box !important;
                margin: 0 !important;
                margin-inline: 0 !important;
                padding: 0 !important;
                box-shadow: none !important;
              }

              .panel-arrowcontent,
              slot[part="content"],
              panel[type="arrow"]::part(content) {
                background-color: var(--panel-background) !important;
                border: 1px solid var(--panel-border-color) !important;
                border-radius: 10px !important;
              }

              panelmultiview,
              panelview {
                width: 100% !important;
                min-width: 100% !important;
                box-sizing: border-box !important;
                margin: 0 !important;
                background: transparent !important;
              }

              panelview,
              .panel-subview-body {
                scrollbar-width: none !important;
                padding-inline-end: 0 !important;
                margin-inline-end: 0 !important;
              }
            '';
            
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

              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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

          profiles.ru = {
            id = 1;
            isDefault = false;
            
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

              "toolkit.legacyUserProfileCustomizations.stylesheets" = false;
            };
            
            search = {
              force = true;
              default = "ddg";
              engines = {
                "bing".metaData.hidden = true;
              };
            };
          };
        };
      });
    };
  };
}
