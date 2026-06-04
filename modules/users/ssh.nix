{ self, inputs, ... }: {
  flake.nixosUsers.ssh = { config, pkgs, ... }:
  let
    username = "ssh";
  in {
    users.users."${username}" = {
      isNormalUser = true;
      description = "ssh";
      extraGroups = [ "networkmanager" "wheel" ];
      hashedPasswordFile = config.sops.secrets."user_root_password".path;
      homeMode = "0755";
    };

    home-manager.users."${username}".home = {
      stateVersion = "26.05";
    };
  };
}
