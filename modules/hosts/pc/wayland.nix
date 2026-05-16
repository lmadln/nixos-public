{ self, inputs, ... }: {
  flake.nixosModules.pcWayland = { config, pkgs, ... }: {
    imports = [
    ];
    services.xserver.videoDrivers = [ "amdgpu" ];
  };
}
