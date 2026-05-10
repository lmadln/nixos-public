{ self, inputs, ... }: {
flake.nixosModules.defaultConfiguration = { config, pkgs, ... }: {
  imports = [];

  environment.systemPackages = with pkgs; [
    killall
    wget
    git
    vim
    sops
  ];
  
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    
    age.sshKeyPaths =[ "/etc/ssh/ssh_host_ed25519_key" ];
    
    secrets."wifi_password" = {};
    secrets."user_password" = {
      neededForUsers = true; 
    };
  };

  custom.username = "alex";
  users.users.${config.custom.username} = {
    isNormalUser = true;
    description = "alex";
    extraGroups = [ "networkmanager" "wheel" "keyd" ];
    hashedPasswordFile = config.sops.secrets."user_password".path;
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
};
}
