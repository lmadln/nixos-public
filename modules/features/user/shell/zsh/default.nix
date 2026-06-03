{ self, inputs, ... }: {
  flake.nixosModules.zsh = { pkgs, config, lib, ... }: 
  let
    users = lib.unique config.user.shell.zsh.users;
    sysConfig = config;
  in
  {
    options.user.shell.zsh.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "zsh";
    };

    config = lib.mkIf (users != []) {

      programs.zsh.enable = true;
      
      environment.systemPackages = [ pkgs.nix-zsh-completions ];
      
      environment.variables = {
        EDITOR = "vim";
        VISUAL = "vim";
      };

      users.users = lib.genAttrs users (user: { 
        shell = pkgs.zsh; 
      });

      home-manager.users = lib.genAttrs users (user: { pkgs, ... }: {
        
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          autocd = true;
          defaultKeymap = "emacs";

          shellAliases = {
            fullclear = "printf '\\033[2J\\033[3J\\033[H'";
            rebuild = "sudo nixos-rebuild switch --flake ~/nixos#${sysConfig.networking.hostName}";
            clean = "sudo nix-collect-garbage -d && rebuild";
          };

          syntaxHighlighting.styles = {
            "command" = "fg=108,bold";
            "alias" = "fg=108,bold";
            "builtin" = "fg=108,bold";
            "unknown-token" = "fg=131";
            "path" = "fg=248";
          };
          
          initContent = ''
            unsetopt flow_control
            stty -ixon
            
            bindkey "''${key[Up]}" history-beginning-search-backward
            bindkey "''${key[Down]}" history-beginning-search-forward
            
            bindkey "^[[H" beginning-of-line
            bindkey "^[[F" end-of-line
            bindkey "^[[1~" beginning-of-line
            bindkey "^[[4~" end-of-line
            bindkey "^[OH" beginning-of-line
            bindkey "^[OF" end-of-line
            bindkey "^[[3~" delete-char
                      
            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word
          '';
        };

        programs.starship = {
          enable = true;
          enableZshIntegration = true;
          
          settings = {
            format = "[\\\[](bold green)$username$hostname $directory[\\\]](bold green)$git_branch$git_status$nix_shell$character";
            
            add_newline = false;

            username = {
              show_always = true;
              style_user = "bold green";
              format = "[$user]($style)";
            };

            hostname = {
              ssh_only = false;
              style = "bold green";
              format = "[@$hostname]($style)";
            };

            directory = {
              style = "bold blue";
              truncation_length = 6;
              format = "[$path]($style)";
            };

            character = {
              success_symbol = "[\\$](bold green)";
              error_symbol = "[\\$](bold green)";
            };

            git_branch = {
              symbol = "";
              style = "bold yellow";
              format = "([\\[$branch\\\]]($style))";
            };

            git_status = {
              style = "bold red";
              format = "([\\[$all_status$ahead_behind\\\]]($style))";
            };

            nix_shell = {
              symbol = "";
              style = "bold blue";
              impure_msg = "[impure shell](bold red)";
              pure_msg = "[pure shell](bold green)";
              unknown_msg = "[unknown shell](bold yellow)";
              format = "[\\(](bold cyan)[$name](bold cyan)[\\)](bold cyan)";
            };

            cmd_duration = {
              min_time = 500;
              style = "bold yellow";
              format = " t:[$duration]($style)";
            };
          };
        };

      });
    };
  };
}
