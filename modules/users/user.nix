{ self, inputs, ... }: {
  flake.nixosUsers.user = { config, pkgs, lib, ... }:
  let
    username = "user";
  in {
    users.users."${username}" = {
      isNormalUser = true;
      description = "user";
      extraGroups = [ "networkmanager" "wheel" "keyd" ];
      hashedPasswordFile = config.sops.secrets."user_user_password".path;
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
    user.apps.v2rayn.users = [ "${username}" ];
    user.apps.obs-studio.users = [ "${username}" ];

    user.cli.fastfetch.users = [ "${username}" ];
    user.cli.yazi.users = [ "${username}" ];

    home-manager.users."${username}".home = {
      stateVersion = "26.05";
      packages = [
        pkgs.spotify
        pkgs.easyeffects # audio effects
        pkgs.atril       # [.pdf, .djvu] viewer
        pkgs.abiword     # [.docx] editor
        pkgs.bitwarden-desktop

        pkgs.pavucontrol
        pkgs.pamixer
        pkgs.playerctl
      ];
    };
  };
}
