{ self, inputs, ... }: {
  flake.nixosUsers.alex = { config, pkgs, lib, ... }:
  let
    username = "alex";
    host = config.networking.hostName;
  in {
    users.users."${username}" = {
      isNormalUser = true;
      description = "alex";
      extraGroups = [ "networkmanager" "wheel" "keyd" ];
      hashedPasswordFile = if (host == "pc") 
        then config.sops.secrets."user_alex_password".path 
        else config.sops.secrets."user_root_password".path;
      homeMode = "0700";
    };

    user.home-manager.users = [ "${username}" ];

    user.shell.zsh.users = [ "${username}" ];

    user.wm.niri.users = [ "${username}" ];

    user.interface.noctalia.users = [ "${username}" ];
    user.interface.cursors.vimix.users = [ "${username}" ];

    user.apps.localsend.users = [ "${username}" ];
    user.apps.kitty.users = [ "${username}" ];
    user.apps.firefox.users = [ "${username}" ];
    user.apps.librewolf.users = [ "${username}" ];
    user.apps.v2rayn.users = [ "${username}" ];
    user.apps.obs-studio.users = [ "${username}" ];
    user.apps.vscode.users = [ "${username}" ];
    user.apps.mpv.users = [ "${username}" ];
    user.apps.imv.users = [ "${username}" ];

    user.cli.fastfetch.users = [ "${username}" ];
    user.cli.yazi.users = [ "${username}" ];

    user.utils.direnv.users = [ "${username}" ];

    sys.flatpak.enable = (host == "pc");
    sys.flatpak.packages = lib.mkIf (host == "pc") [ "com.pot_app.pot" ];

    sys.steam.enable = true;

    home-manager.users."${username}".home = {
      stateVersion = "26.05";
      packages = [
        pkgs.godot
        #pkgs.bitwarden-desktop
        pkgs.spotify
        pkgs.easyeffects # audio effects
        pkgs.atril       # [.pdf, .djvu] viewer
        pkgs.abiword     # [.docx] editor

        pkgs.pavucontrol
        pkgs.pamixer
        pkgs.playerctl
      ];
    };
  };
}
