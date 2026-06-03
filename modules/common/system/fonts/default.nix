{ self, inputs, ... }: {
  flake.nixosSystemModules.fonts = { config, pkgs, ... }: {

    fonts.packages = with pkgs; [
      corefonts
      liberation_ttf
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      font-awesome
    ];
  };
}
