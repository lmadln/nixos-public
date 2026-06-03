{ self, inputs, ... }: {
  flake.nixosModules.kitty = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.apps.kitty.users;
  in {

    options.user.apps.kitty.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Kitty terminal";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {

        programs.kitty.enable = true;
        
        programs.kitty.settings = {
            font_family = "JetBrainsMono Nerd Font";
            confirm_os_window_close = 0;
            font_size = 12.0;
            cursor_shape = "beam";
            cursor_beam_thickness = 1.5;
            cursor_trail = 3;
            window_margin_width = 5;
            enable_audio_bell = false;
            allow_remote_control = true;
            
            include = "themes/noctalia.conf";
        };
      });
    };
  };
}
