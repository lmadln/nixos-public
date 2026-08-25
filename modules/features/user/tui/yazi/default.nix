{ self, inputs, ... }: {
  flake.nixosModules.yazi = { pkgs, config, lib, ... }: 
  let
    users = lib.unique config.user.tui.yazi.users;
  in {
    options.user.tui.yazi.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Yazi file explorer";
    };
    config = lib.mkIf (users != []) {
      home-manager.users = lib.genAttrs users (user: {
        programs.yazi = {
          enable = true;

          enableBashIntegration = true;
          enableZshIntegration = true;
          shellWrapperName = "y";

          extraPackages = with pkgs; [
            exiftool
          ];
        
          keymap = {
            mgr.prepend_keymap = [
              { on = [ "Y" ]; run  = "shell \"for f in \"%s\"; do echo \"file://$f\"; done | wl-copy -t text/uri-list\" --confirm"; }
            ];
          };

          settings = {
            mgr = {
              sort_by = "natural";
              sort_dir_first = true;
              ratio = [ 1 4 4 ];
              linemode = "size";
            };
            opener = {
              copy = [
                { run = ''wl-copy < %s''; orphan = true; desc = "Copy"; }
              ];
              copy_image = [
                { run = ''wl-copy -t image/png < %s''; orphan = true; desc = "Copy"; }
              ];
              open_image = [
                { run = ''imv "%s"''; orphan = true; desc = "Imv"; }
              ];
              open_video = [
                { run = ''mpv --force-window "%s"''; orphan = true; desc = "Mpv"; }
              ];
              open_audio = [
                { run = ''mpv --force-window "%s"''; orphan = true; desc = "Mpv"; }
              ];
              edit_text = [
                { run = ''nano "%s"''; block = true; desc = "Nano"; }
                { run = ''vim "%s"''; block = true; desc = "Vim"; }
                { run = ''codium "%s"''; orphan = true; desc = "VSCode"; }
                { run = ''abiword "%s"''; orphan = true; desc = "Abiword"; }
              ];
              view_pdf = [
                { run = ''atril "%s"''; orphan = true; desc = "Atril"; }
              ];
              browser = [
                { run = ''librewolf "%s"''; orphan = true; desc = "Librewolf"; }
                { run = ''firefox "%s"''; orphan = true; desc = "Firefox"; }
              ];
              edit_document = [
                { run = ''abiword "%s"''; orphan = true; desc = "Abiword"; }
              ];
              open_folder = [
                { run = ''codium "%s"''; orphan = true; desc = "VSCode"; }
              ];
              system =[ { run = "xdg-open \"%s\""; orphan = true; desc = "System default"; } ];
              reveal =[
                { 
                  run = "if [ -d \"$1\" ]; then cd \"$1\"; else cd \"$(dirname \"$1\")\"; fi && kitty"; 
                  orphan = true; 
                  desc = "Reveal"; 
                }
              ];
              show_exif =[
                { 
                  run = "exiftool \"%s\" | less"; 
                  block = true; 
                  desc = "Show EXIF"; 
                }
              ];
            };
            open = {
              rules = [
                { mime = "folder/*"; use = [ "reveal" "open_folder" ]; }
                  
                { mime = "inode/empty"; use = [ "edit_text" "reveal" "show_exif" ]; }
                  
                { mime = "text/*"; use = [ "edit_text" "copy" "reveal" "show_exif" ]; }
                { mime = "application/json"; use = [ "edit_text" "open_term" "show_exif" ]; }
                  
                { mime = "application/pdf"; use = [ "view_pdf" "browser" "system" "reveal" "show_exif" ]; }
                  
                { mime = "application/msword"; use = [ "edit_document" "system" "reveal" "show_exif" ]; }
                { mime = "application/openxmlformats-officedocument.wordprocessingml.document"; use = [ "edit_document" "system" "reveal" "show_exif" ]; }
                { mime = "application/openxmlformats-officedocument.wordprocessingml.template"; use = [ "edit_document" "system" "reveal" "show_exif" ]; }
                { mime = "application/oasis.opendocument.text"; use = [ "edit_document" "system" "reveal" "show_exif" ]; }
                { mime = "application/rtf"; use = [ "edit_document" "system" "reveal" "show_exif" ]; }
                { mime = "text/rtf"; use = [ "edit_document" "system" "reveal" "show_exif" ]; }
                  
                { mime = "image/*"; use = [ "system" "open_image" "browser" "copy_image" "reveal" "show_exif" ]; }
                { mime = "video/*"; use = [ "system" "open_video" "browser" "reveal" "show_exif" ]; }
                { mime = "audio/*"; use = [ "system" "open_audio" "browser" "reveal" "show_exif" ]; }
                  
                { url = "*"; use =[ "system" "reveal" "show_exif" ]; }
              ];
            };
          };
        };
      });
    };
  };
}
