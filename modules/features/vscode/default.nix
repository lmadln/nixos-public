{ self, inputs, ... }: {
  flake.nixosModules.vscode = { pkgs, config, ... }:
  let
    marketplace = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
    patchedNoctaliaTheme = marketplace.noctalia.noctaliatheme.overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        # Укажите точный путь к папке themes внутри пакета расширения
        THEME_DIR="$out/share/vscode/extensions/noctalia.noctaliatheme/themes"
        
        # Точное имя файла темы (обычно это что-то вроде theme.json или noctalia-color-theme.json)
        THEME_FILE="$THEME_DIR/NoctaliaTheme-color-theme.json"
        
        # 1. Удаляем неизменяемый файл из пакета
        rm -f "$THEME_FILE"
        
        # 2. Создаем абсолютный симлинк на файл в вашей домашней директории.
        # Важно: используем абсолютный путь (Nix не понимает $HOME и ~ на этапе сборки в песочнице)
        ln -s "/home/${config.custom.username}/.config/noctalia-vscode-theme.json" "$THEME_FILE"
        # ln -s "$out/share/vscode/extensions" "/home/${config.custom.username}/.vscode-oss/extensions/noctalia.noctaliatheme-0.0.5-universal"
      '';
    });
  in
  {
    home-manager.users."${config.custom.username}" = { pkgs, ... }: {
      programs.vscodium = {
        enable = true;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            ms-toolsai.jupyter
            ms-toolsai.jupyter-renderers
            ms-python.python
            ms-vscode.cpptools
            marketplace.kdl-org.kdl
            mkhl.direnv
            patchedNoctaliaTheme
          ];
          
          userSettings = {
            "window.titleBarStyle" = "custom";
            "workbench.colorTheme" = "NoctaliaTheme";
            "editor.fontLigatures" = true;
            "jupyter.askForKernelRestart" = false;
            "C_Cpp.intelliSenseEngine" = "default";
            "C_Cpp.default.cppStandard" = "c++20";
            "C_Cpp.default.cStandard" = "c17";
          };
        };
      };
      home.file.".vscode-oss/extensions/noctalia.noctaliatheme-0.0.5-universal".source = "${patchedNoctaliaTheme}/share/vscode/extensions/noctalia.noctaliatheme";
      home.packages = with pkgs;[
        (writeShellScriptBin "code-oss" "exec codium \"$@\"")
        (writeShellScriptBin "code" "exec codium \"$@\"")
      ];
    };
  };
}
