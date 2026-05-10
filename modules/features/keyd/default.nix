{ self, inputs, ... }: {
  flake.nixosModules.keyd = { pkgs, ... }: {
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            leftmeta = "timeout(overload(meta, M-f1), 100, layer(meta))";
            pause = "leftmeta";
          };
        };
      };
    };
  };
}
