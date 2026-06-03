{ self, inputs, ... }: {
  flake.nixosUsers.root = { config, pkgs, ... }: {
    users.users.root = {
      hashedPasswordFile = config.sops.secrets."user_root_password".path;
    };
  };
}
