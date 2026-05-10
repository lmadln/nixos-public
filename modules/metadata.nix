{ self, inputs, ... }: {
  flake.nixosModules.metadata = { lib, ... }: {
    options.custom = {
      username = lib.mkOption {
        type = lib.types.str;
        description = "Username";
      };
    };
  };
}
