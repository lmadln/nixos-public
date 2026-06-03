{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, config, lib, ... }: 
  let
    users = lib.unique config.user.wm.niri.users;
  in
  {
    options.user.wm.niri.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Niri WM";
    };

    config = lib.mkIf (users != []) {
      programs.niri.enable = true;

      user.apps.kitty.users = users;

      environment.systemPackages = with pkgs; [
        wl-clipboard
      ];

      home-manager.users = lib.genAttrs users (user: { config, ... }: {              
        xdg.configFile = {
          "niri/config.kdl".source = ./config.kdl;
          "niri/conf.d".source = ./conf.d;
        };

        home.packages = [
          pkgs.xwayland-satellite

          pkgs.grim
          pkgs.slurp
          pkgs.satty

          (pkgs.writeShellScriptBin "toggle_workspace" (builtins.readFile ./scripts/toggle_workspace.sh))
          (pkgs.writeShellScriptBin "niri_panic" (builtins.readFile ./scripts/panic.sh))
        ];

        home.activation.setupNoctalia = config.lib.dag.entryAfter ["writeBoundary"] ''
          $DRY_RUN_CMD mkdir -p "${config.xdg.configHome}/niri"
          if [ ! -f "${config.xdg.configHome}/niri/noctalia.kdl" ]; then
            $DRY_RUN_CMD touch "${config.xdg.configHome}/niri/noctalia.kdl"
          fi
        '';        
      });
    };
  };
}
