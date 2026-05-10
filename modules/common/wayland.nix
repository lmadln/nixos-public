{ self, inputs, ... }: {
flake.nixosModules.wayland = { config, pkgs, ... }: {
  imports = [
    self.nixosModules.keyd
  ];

  environment.systemPackages = with pkgs; [
    # Visual
    vimix-cursors
    
    # Utils
    libnotify
    brightnessctl
    pavucontrol
    pamixer
    playerctl
  ];

  boot.kernelParams = [ 
    "quiet"
    "splash"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
    "video.use_native_backlight=1"
  ];

  programs.xwayland.enable = true;

  services.displayManager.ly.enable = true;
  services.displayManager.defaultSession = "niri";
  
  # Plymouth
  boot.plymouth = {
    enable = true;
    theme = "breeze"; # bgrt, spinner, breeze
  };
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  
  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  # 
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
  
  # Polkit
  security.polkit.enable = true;
  programs.dconf.enable = true;
  
  # Wayland graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  fonts.packages = with pkgs;[
    corefonts # (Arial, Times New Roman)
    liberation_ttf
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    font-awesome
  ];
  
}
