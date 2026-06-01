{ self, inputs, ... }: {
  flake.nixosModules.niriSettings = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
  in
  {
    home_manager.users.${username}.programs.niri.settings = {
      prefer-no-csd = true;
      input.keyboard.xkb = {
        layout = "us";
      };
      layout = {
        gaps = 4;
        focus-ring = {
          enable = true;
          width = 2;
        };
      };
    };
  };
}
