{ self, inputs, ... }: {
  flake.nixosModules.mpv = { config, pkgs, lib, ... }:
  let
    users = lib.unique config.user.apps.mpv.users;
  in {
    options.user.apps.mpv.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Localsend";
    };
    config = lib.mkIf (users != []) {
      home-manager.users = lib.genAttrs users (user: {
        programs.mpv = {
          enable = true;
  
          config = {
            profile = "gpu-hq";
            ytdl-format = "bestvideo+bestaudio";
            hwdec = "auto-safe";

            keep-open = "yes";

            http-proxy = "http://127.0.0.1:10808";
            ytdl-raw-options = "proxy=http://127.0.0.1:10808";
          };

          bindings = {
            "RIGHT"      = "seek 5";
            "LEFT"       = "seek -5";
            "L"          = "seek 10";
            "J"          = "seek -10";
            "UP"         = "add volume 5";
            "DOWN"       = "add volume -5";
          };

          scripts = [
            pkgs.mpvScripts.uosc
            pkgs.mpvScripts.thumbfast
            pkgs.mpvScripts.mpris
            pkgs.mpvScripts.sponsorblock
          ];
        };
      });
    };
  };
}
