{ self, inputs, ... }: {
  flake.nixosModules.obs-studio = { pkgs, config, lib, ... }:
  let
    users = lib.unique config.user.apps.obs-studio.users;
  in {
    options.user.apps.obs-studio.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "obs-studio";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {
        programs.obs-studio = {
          enable = true;
          plugins = with pkgs.obs-studio-plugins; [
            wlrobs
            obs-pipewire-audio-capture
            obs-backgroundremoval
          ];
        };
      });
    };
  };
}
