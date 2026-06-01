{ self, inputs, ... }: {
  flake.nixosUsers.alex = { config, pkgs, ... }:
  let
    username = "alex";
  in {
    imports = [
    ];

    myFeatures.home-manager.enableFor = [ "${username}" ];
    myFeatures.localsend.enableFor = [ "${username}" ];

    users.users."${username}" = {
      isNormalUser = true;
      description = "alex";
      extraGroups = [ "networkmanager" "wheel" "keyd" ];
      hashedPasswordFile = config.sops.secrets."user_password".path;
    };
  };
}
