{ self, inputs, ... }: {
  flake.nixosModules.spotify = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.apps.spotify.users;
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {

    options.user.apps.spotify.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "spotify + spicetify";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {

        imports = [ inputs.spicetify-nix.homeManagerModules.default ];

        programs.spicetify = {
          enable = true;

          theme = spicePkgs.themes.sleek;
          colorScheme = "BladeRunner";

          enabledExtensions = with spicePkgs.extensions; [
            adblock
            hidePodcasts
            shuffle
          ];

          enabledCustomApps = with spicePkgs.apps; [
            newReleases
            ncsVisualizer
          ];
        };

        home.packages = [
        ];
      });
    };
  };
}
