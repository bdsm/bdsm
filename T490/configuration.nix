{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.11"; 
  
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_testing;
  };
  
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    permittedInsecurePackages = [ "electron-25.9.0" ];
  };
 
  networking = {
    hostName = "eris";
    networkmanager.enable = true;
  };
  
  security = { 
    doas = {
      enable = true;
      extraConfig = "permit nopass :wheel";
    };
    rtkit.enable = true;
    pam.services.swaylock = {};
  };

  virtualisation = {
    virtualbox.host.enable = true;
    docker.enable = true;
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true; 
    };
    steam.enable = true;
    java.enable = true; 
  };
  
  services = {
    printing.enable = true; 
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;
      };
    };
  };

  users.users.cherry = {
    isNormalUser = true;
    description = "trash";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "docker" ];
    shell = pkgs.elvish;
    packages = with pkgs; [
      neofetch # :^)
      neovim 
      go
      ruby_3_3
      fortune
      cowsay
      firefox
      tor-browser
      blender
      obsidian
      drawterm-wayland
      qbittorrent
      discord
      prismlauncher
      telegram-desktop
      dolphin
      drawing
      gimp
      (retroarch.override { cores = with libretro ; [ beetle-psx-hw ]; })
    ];
  };

  environment.systemPackages = with pkgs; [
    plan9port
    killall
    p7zip
    pavucontrol
    wget
    htop
    emacs
    nano
    vim
    git
    mercurial
    kitty
    waybar
    swaybg
    swaylock
    wofi
    brightnessctl
    grim
    slurp
    wl-clipboard
  ];
  
  fonts.packages = with pkgs; [
      tamzen
      noto-fonts
      noto-fonts-emoji
      fantasque-sans-mono
      jetbrains-mono
    ];
  };

}
