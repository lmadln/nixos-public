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

        extraPackages = with pkgs; [
          exiftool
        ];

        settings = {
            mgr = {
                sort_by = "natural";
                sort_dir_first = true;
                ratio = [ 1 4 4 ];
                linemode = "size";
            };
            opener = {
                edit_text = [
                    { run = ''nano "$@"''; block = true; desc = "Nano"; }
                    { run = ''vim "$@"''; block = true; desc = "Vim"; }
                    { run = ''codium "$@"''; block = true; desc = "VSCode"; }
                ];
                view_pdf = [
                    { run = ''atril "$@"''; block = true; desc = "Atril"; }
                    { run = ''librewolf "$@"''; block = true; desc = "Librewolf"; }
                    { run = ''firefox "$@"''; block = true; desc = "Firefox"; }
                ];
                open_folder = [
                    { run = ''codium "$@"''; block = true; desc = "VSCode"; }
                ];
                system =[ { run = "xdg-open \"$@\""; orphan = true; desc = "System default"; } ];
                reveal =[
                  { 
                    run = "if [ -d \"$1\" ]; then cd \"$1\"; else cd \"$(dirname \"$1\")\"; fi && kitty"; 
                    orphan = true; 
                    desc = "Reveal"; 
                  }
                ];
                show_exif =[
                  { 
                    run = "exiftool \"$@\" | less"; 
                    block = true; 
                    desc = "Show EXIF"; 
                  }
                ];
            };
            open = {
                rules = [
                  { mime = "folder/*"; use = [ "reveal" "open_folder" ]; }
                  
                  { mime = "inode/empty"; use = [ "edit_text" "reveal" "show_exif" ]; }
                  
                  { mime = "text/*"; use = [ "edit_text" "reveal" "show_exif" ]; }
                  { mime = "application/json"; use = [ "edit_text" "open_term" "show_exif" ]; }
                  
                  { mime = "image/*"; use = [ "system" "reveal" "show_exif" ]; }
                  { mime = "video/*"; use = [ "system" "reveal" "show_exif" ]; }
                  { mime = "audio/*"; use = [ "system" "reveal" "show_exif" ]; }
                  
                  { mime = "application/pdf"; use = [ "view_pdf" "system" "reveal" "show_exif" ]; }
                  
                  { url = "*"; use =[ "system" "reveal" "show_exif" ]; }
                ];
            };
        };
      };
    };
  };
}
