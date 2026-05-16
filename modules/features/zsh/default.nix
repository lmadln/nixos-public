{ self, inputs, ... }: {
  flake.nixosModules.zsh = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    flakeDir = "/home/${username}/nixos";
    hostName = config.networking.hostName;
  in
  {
    environment.variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    environment.systemPackages = with pkgs; [
      nix-zsh-completions
    ];

    programs.zsh.enable = true;
    users.users."${username}".shell = pkgs.zsh;

    home-manager.users."${username}" = { config, ... }: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        
        autocd = true;
        
        defaultKeymap = "emacs";

        shellAliases = {
          fullclear = "printf '\\033[2J\\033[3J\\033[H'";
          rebuild = "sudo nixos-rebuild switch --flake ~/nixos#${hostName}";
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
      };

      home.file.".config/starship.toml".source = 
        config.lib.file.mkOutOfStoreSymlink "${flakeDir}/modules/features/zsh/starship.toml";
    };
  };
}
