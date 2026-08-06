{ self, inputs, ... }: {
  flake.nixosModules.spotify = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.apps.spotify.users;
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {

    options.user.apps.spotify.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "spotify + spicetify";
    };

    config = lib.mkIf (users != []) {
      
      imports = [
         inputs.spicetify-nix.nixosModules.default
      ];

      home-manager.users = lib.genAttrs users (user: {

        programs.spicetify = [
          enable = true;

         theme = spicePkgs.themes.catppuccin;
         colorScheme = "mocha";

         enabledExtensions = with spicePkgs.extensions; [
           adblock
           hidePodcasts
           shuffle
         ];

         enabledCustomApps = with spicePkgs.apps; [
           newReleases
            ncsVisualizer
          ];
        ];

        home.packages = [
          pkgs.spotify;
        ];
      });
    };
  };
}
