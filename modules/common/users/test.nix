{ self, inputs, ... }: {
  flake.nixosUsers.test = { config, pkgs, ... }: {
    users.users.test = {
      isNormalUser = true;
      description = "test";
      extraGroups = [ "networkmanager" "wheel" "keyd" ];
      initialPassword = "1234";
    };
    myFeatures.localsend.enableFor = [ "test" ];
  };
}
