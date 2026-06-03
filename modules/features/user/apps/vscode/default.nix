{ self, inputs, ... }: {
  flake.nixosModules.vscode = { pkgs, config, lib, ... }:
  let
    marketplace = inputs.vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
    users = lib.unique config.user.apps.vscode.users;
  in
  {

    options.user.apps.vscode.users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "vscode";
    };

    config = lib.mkIf (users != []) {

      home-manager.users = lib.genAttrs users (user: {
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
              noctalia.noctaliatheme
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

          #home.file.".vscode-oss/extensions/noctalia.noctaliatheme-0.0.5-universal".source = "${patchedNoctaliaTheme}/share/vscode/extensions/noctalia.noctaliatheme";
          home.packages = with pkgs;[
            (writeShellScriptBin "code-oss" "exec codium \"$@\"")
            (writeShellScriptBin "code" "exec codium \"$@\"")
          ];
        };
      });
    };
  };
}
