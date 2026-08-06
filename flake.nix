{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    #noctalia5 = {
    #  url = "github:noctalia-dev/noctalia-shell/v5";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    
    nur.url = "github:nix-community/NUR";
    
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  
  outputs = inputs@{ self, flake-parts, import-tree, ... }: flake-parts.lib.mkFlake {inherit inputs;} {
    
    options = {
      flake = inputs.flake-parts.lib.mkSubmoduleOptions {
        nixosConfigurationModules = inputs.nixpkgs.lib.mkOption {
          type = inputs.nixpkgs.lib.types.lazyAttrsOf inputs.nixpkgs.lib.types.unspecified;
          default = {};
          description = "";
        };
        nixosHardware = inputs.nixpkgs.lib.mkOption {
          type = inputs.nixpkgs.lib.types.lazyAttrsOf inputs.nixpkgs.lib.types.unspecified;
          default = {};
          description = "";
        };
        nixosUsers = inputs.nixpkgs.lib.mkOption {
          type = inputs.nixpkgs.lib.types.lazyAttrsOf inputs.nixpkgs.lib.types.unspecified;
          default = {};
          description = "";
        };
        nixosSystemModules = inputs.nixpkgs.lib.mkOption {
          type = inputs.nixpkgs.lib.types.lazyAttrsOf inputs.nixpkgs.lib.types.unspecified;
          default = {};
          description = "";
        };
      };
    };

    imports = [ (import-tree ./modules) ];
  };
}
