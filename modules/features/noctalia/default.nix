{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    custom-noctalia = pkgs.noctalia-shell.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or []) ++[
        ./color-tweak.patch
      ];
    });
  in
  {
    environment.systemPackages = [
      custom-noctalia
      pkgs.python3
    ];
    
    home-manager.users."${username}" = { config, ... }: {
      home.file.".config/noctalia/settings.json".source = 
        config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos/modules/features/noctalia/settings.json";
    };
  };
}
