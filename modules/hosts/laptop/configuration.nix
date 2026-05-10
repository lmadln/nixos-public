{ self, inputs, ... }: {

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

flake.nixosModules.laptopConfiguration = { config, pkgs, ... }: {
  imports = [
    self.nixosModules.laptopHardware
    self.nixosModules.metadata
    self.nixosModules.home-manager
    
    self.nixosModules.niri
    self.nixosModules.noctalia
    
    self.nixosModules.firefox
    self.nixosModules.librewolf
    self.nixosModules.steam
    self.nixosModules.obs-studio
    self.nixosModules.vscode
    
    self.nixosModules.kitty
    self.nixosModules.zsh
    self.nixosModules.keyd
    
    self.nixosModules.fastfetch
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Plymouth
  boot.plymouth = {
    enable = true;
    theme = "breeze"; # bgrt, spinner, breeze
  };
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  
  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
        
    useOSProber = true;
  };
  boot.loader.timeout = 15;
  
  services.displayManager.ly.enable = true;
  services.displayManager.defaultSession = "niri";
  
  boot.kernelParams = [ 
    "quiet"
    "splash"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
    "video.use_native_backlight=1"
  ];
  
  # Polkit
  security.polkit.enable = true;
  programs.dconf.enable = true;
  
  # Wayland graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  programs.xwayland.enable = true;
  
  networking.hostName = "laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # laptop stuff  
  services.upower.enable = true;
  services.acpid.enable = true;
  services.power-profiles-daemon.enable = true;
  
  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  
  nix.settings.trusted-users =[ "root" "@wheel" ];
  
  # Misc laptop stuff
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;
  
  # SSD stuff
  nix.settings.auto-optimise-store = true;
  services.fstrim.enable = true;
  
  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  services.thermald.enable = true;
  
  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
  
  # USB drives services
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Visual
    vimix-cursors
    
    
    # Utils
    btop
    jq
    os-prober
    libnotify
    brightnessctl
    python3
    xwayland-satellite
    pavucontrol
    pamixer
    playerctl

    # Disks management
    udisks
    eudev
    usbutils
    
    # Programs
    telegram-desktop
    spotify
    godot
    clash-verge-rev
  ];
  
  fonts.packages = with pkgs;[
    corefonts # (Arial, Times New Roman)
    liberation_ttf
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    font-awesome
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
  
};
}
