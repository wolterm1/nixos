# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs,  ... }:
let
  user = "matthiasw";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./extra_config/zsh.nix
      ./extra_config/sound.nix
      ./extra_config/security.nix
];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  

  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
		 
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true; 

  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };


  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "de";
      variant = "";
    };
  };


  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" "input" ];
    packages = with pkgs; [
      #thunderbird
    ];
  };


  #home-manager user from the flake
  #home-manager.users.${user} = flake-self.homeConfigurations.desktop;

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = true;
    user = "matthiasw";
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
    wget
    vim
    openvpn
    git
    libnotify
    pipewire
    networkmanager
    networkmanagerapplet
    polkit
];
  



  system.stateVersion = "24.05"; # Did you read the comment?



  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "matthiasw" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 7d"; };
  };

}
