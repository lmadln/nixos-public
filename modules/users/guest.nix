{ self, inputs, ... }: {
  flake.nixosUsers.guest = { config, pkgs, ... }:
  let
    username = "guest";
  in {
    users.users."${username}" = {
      isNormalUser = true;
      description = "test";
      extraGroups = [ "networkmanager" ];
      initialPassword = "";
      homeMode = "0755";
    };

    home-manager.users."${username}".home.stateVersion = "26.05";

    #myFeatures.home-manager.users = [ "${username}" ];
    #myFeatures.yazi.users = [ "${username}" ];
    #myFeatures.zsh.users = [ "${username}" ];
    #myFeatures.fastfetch.users = [ "${username}" ];
  };
}
