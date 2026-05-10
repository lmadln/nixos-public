{ self, inputs, ... }: {
  flake.nixosModules.zsh = { pkgs, config, lib, ... }: 
  let
    username = config.custom.username;
    flakeDir = "/home/${username}/nixos";
  in
  {
    environment.variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };

    environment.systemPackages = with pkgs; [
      yazi
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
          rebuild = "sudo nixos-rebuild switch --flake ${flakeDir}";
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
          setopt correct
          
          bindkey "''${key[Up]}" up-line-or-search
          bindkey "''${key[Down]}" down-line-or-search
          
          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          
          function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
            yazi "$@" --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
            fi
            rm -f -- "$tmp"
          }
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
