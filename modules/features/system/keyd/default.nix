{ self, inputs, ... }: {
  flake.nixosModules.keyd = { pkgs, config, lib, ... }: 
  let
    cfg = config.sys.keyd; 
  in {

    options.sys.keyd = {
      enable = lib.mkEnableOption "Keyd keyboard remapping daemon";
    };

    config = lib.mkIf cfg.enable {
      
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
  };
}
