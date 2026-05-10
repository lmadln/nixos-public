#{ self, inputs, ... }: {
#  flake.nixosModules.fastfetch = { pkgs, config, ... }: 
#  let
#    username = config.custom.username;
#  in
#  {
#    environment.systemPackages = [ pkgs.fastfetch ];
#    
#    home-manager.users."${username}" = { config, ... }: {
#      home.file.".config/fastfetch/config.json".source = 
#        config.lib.file.mkOutOfStoreSymlink "/home/${username}/nixos/modules/features/fastfetch/config.json";
#    };
#  };
#}

{ self, inputs, ... }: {
  flake.nixosModules.fastfetch = { pkgs, config, ... }: 
  let
    username = config.custom.username;
  in
  {
    home-manager.users."${username}" = { ... }: {
      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "data";
            source = ''
      .    ,-.    .      
     oO\   \  \  / \     
     \OO\   \  \/  /     
  ,oO0OO0OOOo\   ,/ o\   
 <oOOOOOOOOOOo\  \ /O0;  
      /``/     \  ,OO/   
,────'  /       \,OOOOoo,
\___   o\       /0O/OOo>`
   /  oOO\_____/OO/____  
  `  / \OO\    `"`     / 
   \/ /0OOO\~──.  .──~`  
     /OO/\OO\   \  \     
     \0/  \O0\   \  \    
           `"`    `~`
            '';
            padding = {
              top = 1;
              left = 1;
              right = 4;
            };
          };
          display = {
            separator = "  ";
            color = {
              keys = "blue";
            };
          };
          #modules =[
          #  "break"
          #  "title"
          #  "separator"
          #  { type = "os"; key = " OS"; }
          #  { type = "kernel"; key = " Kernel"; }
          #  { type = "packages"; key = "󰏗 Packages"; }
          #  { type = "shell"; key = " Shell"; }
          #  { type = "wm"; key = " WM"; }
          #  { type = "uptime"; key = "󰅐 Uptime"; }
          #  { type = "memory"; key = "󰍛 Memory"; }
          #  { type = "cpu"; key = " CPU"; format = "{1}"; }
          #  { type = "gpu"; key = "󰢮 GPU"; format = "{2}"; }
          #  "break"
          #  "colors"
          #];
          modules =[
            {
              type = "custom";
              key = "╭───────────╮";
            }
            {
              type = "os";
              key = "│ {#33} distro  {#keys}│";
            }
            {
              type = "kernel";
              key = "│ {#33}{icon} kernel  {#keys}│";
            }
            {
              type = "uptime";
              key = "│ {#33}󰅐 uptime  {#keys}│";
            }
            {
              type = "title";
              key = "│ {#33}󰏗 pkgs    {#keys}│";
              format = "{user-name}";
            }
            {
              type = "wm";
              key = "│ {#33} wm      {#keys}│";
            }
            {
              type = "terminal";
              key = "│ {#33} term    {#keys}│";
            }
            {
              type = "shell";
              key = "│ {#33} shell   {#keys}│";
            }
            {
              type = "cpu";
              key = "│ {#33}󰍛 cpu     {#keys}│";
              showPeCoreCount = false;
            }
            {
              type = "gpu";
              key = "│ {#33}󰢮 gpu     {#keys}│";
            }
            {
              type = "memory";
              key = "│ {#33} memory  {#keys}│";
            }
            {
              type = "disk";
              key = "│ {#33}󰉉 disk    {#keys}│";
              folders = "/";
            }
            {
              type = "custom";
              key = "├───────────┤";
            }
            {
              type = "colors";
              key = "│ {#39} colors  {#keys}│";
              symbol = "circle";
            }
            {
              type = "custom";
              key = "╰───────────╯";
            }
          ];
        };
      };
    };
  };
}
