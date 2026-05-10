{ self, inputs, ... }: {
  flake.nixosModules.obs-studio = { pkgs, config, ... }: {
    home-manager.users."${config.custom.username}" = { pkgs, ... }: {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
          obs-backgroundremoval
        ];
      };
    };
  };
}
