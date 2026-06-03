{ self, inputs, ... }: {
  flake.nixosModules.core = { config, pkgs, ... }: {
    imports = [
      self.nixosUsers.root
    ];
  
    environment.systemPackages = with pkgs; [
      killall
      btop
      wget
      git
      vim
      jq
      usbutils
      sops
    ];
  
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  
    nix.settings.trusted-users =[ "root" "@wheel" ];
  
    # SSD stuff
    nix.settings.auto-optimise-store = true;
    services.fstrim.enable = true;

    services.udisks2.enable = true;
  
    # Bootloader
    boot.loader.systemd-boot.enable = true; # false;
    boot.loader.timeout = 15;
    
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";      
      age.sshKeyPaths =[ "/etc/ssh/ssh_host_ed25519_key" ];
      
      secrets."user_alex_password" = {
        neededForUsers = true; 
      };
      secrets."user_user_password" = {
        neededForUsers = true; 
      };
      secrets."user_root_password" = {
        neededForUsers = true; 
      };
    };
    
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  
    # Enable networking
    networking.networkmanager.enable = true;
            
    # Set your time zone.
    time.timeZone = "Europe/Moscow";
    
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  
    # Garbage collection
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
    };
    
    

    
    system.stateVersion = "25.11";
  };
}
