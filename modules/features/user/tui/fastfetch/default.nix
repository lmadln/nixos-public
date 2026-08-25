{ self, inputs, ... }: {
  flake.nixosModules.fastfetch = { config, lib, pkgs, ... }: 
  let
    users = lib.unique config.user.cli.fastfetch.users;
  in {

    options.user.cli.fastfetch.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Fastfetch system info util";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {
        
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
      });
    };
  };
}
