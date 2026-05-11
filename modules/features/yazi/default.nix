{ self, inputs, ... }: {
  flake.nixosModules.yazi = { pkgs, config, ... }: 
  let
    username = config.custom.username;
  in
  {
    home-manager.users."${username}" = { pkgs, config, ... }: {
      programs.yazi = {
        enable = true;

        enableBashIntegration = true;
        enableZshIntegration = true;
        shellWrapperName = "y";

        settings = {
            manager = {
                show_hidden = true;
                sort_by = "natural";
                sort_dir_first = true;
                ratio = [ 1 4 4 ];
                linemode = "size";
            };
            opener = {
                edit = [
                    { run = ''nano "$@"''; block = true; desc = "nano"; }
                ];
            };
            open = {
                prepend_rules = [
                    { mime = "text/*"; use = "edit"; }
                ];
            };
        };
      };
    };
  };
}