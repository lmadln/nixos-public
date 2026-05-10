{ self, inputs, ... }: {

  flake.nixosModules.niri = { config, pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    
    #environment.systemPackages = with pkgs;[
    #  slurp
    #  grim
    #  # wl-clipboard
    #];
  };
  
  perSystem = { pkgs, lib, self', ... }: {
  
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        input.keyboard = {
          xkb.layout = "us,ru";
          xkb.options = "grp:alt_shift_toggle";
          repeat-delay = 200;
          repeat-rate = 35;
          numlock = true;
        };
        input.touchpad = {
          tap = _: {};
          natural-scroll = _: {};
          dwt = _: {};  # disable while typing
          accel-speed = 0.5;
          accel-profile = "adaptive";  # or "flat"
          click-method = "clickfinger";  # or "button-areas"
        };
        input.mouse = {
          accel-speed = -0.2;
          scroll-method = "on-button-down";
          scroll-button = 274;  # BTN_MIDDLE
        };
        input.focus-follows-mouse = _: {};
          # props.max-scroll-amount = "20%";

        outputs = {
          "eDP-1" = {
            mode = "1920x1080@60.0";
            scale = 1.0;
            transform = "normal";
          };
          
          "DP-1" = {
            mode = "2560x1440@179.999";
            scale = 1.0;
            transform = "normal";
            backdrop-color = "#222";
          };
        };
        
        cursor = {
          xcursor-theme = "Vimix-cursors";
          xcursor-size = 16;
          hide-after-inactive-ms = 30000;
        };
        
        prefer-no-csd = true;
        
        binds = import ./_binds.nix { inherit lib pkgs self'; };
        
        layout = {
          gaps = 10;
        };

        window-rules = [{
          geometry-corner-radius = 10;
          clip-to-geometry = true;
          draw-border-with-background = false;
        }];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        spawn-at-startup = [ 
          (lib.getExe self'.packages.myKitty)
          (lib.getExe self'.packages.myNoctalia)
        ];
      };
    };

  };

}
