{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  system.stateVersion = "21.11"; 
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };   
  
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    kernelPackages = pkgs.linuxPackages_latest-libre;
  };
 
  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
  };
 
  security = {
    doas = {
      enable = true;
      extraConfig =  "permit nopass :wheel as root";
    };
    rtkit.enable = true; 
  };
 
  networking = {
    hostName = "phrenology";
    networkmanager = {
      enable = true;
      packages = [ pkgs.networkmanagerapplet ];
    };
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; 
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako 
      wofi 
      waybar
      flashfocus
    ];
  };

  services = {
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  users.users.ash = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "docker" ];
    shell = pkgs.elvish;
  };

  environment = {
    systemPackages = with pkgs; [
      plan9port
      killall
      wget
      emacs
      nano
      vim
      firefox
      git
      mercurial 
      qt5ct
      android-tools
    ];
    variables.QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [ 
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      ubuntu_font_family
    ];
    fontconfig.defaultFonts = {
      serif = [ "Ubuntu" ];
      sansSerif = [ "Ubuntu" ];
      monospace = [ "Ubuntu" ];
    };
  };

}
