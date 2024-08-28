# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, flake-self, ... }:
let
  user = "matthiasw";
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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



  services.libinput.touchpad.naturalScrolling = true;
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
  };
  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  services.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true; 


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

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" "scanner" ];
    packages = with pkgs; [
      #thunderbird
    ];
  };

  home-manager.users.${user} = flake-self.homeConfigurations.desktop;

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = true;
    user = "matthiasw";
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;



  systemd.services."autovt@tty1".enable = false;


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
    htop
    wget
    vim
    libsForQt5.bismuth
    openvpn
  ];




  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      upd = "sudo nixos-rebuild switch --flake .#matthiasw";
      c = "clear";
      config = "cd ~/Repos";
      project = "cd ~/Coding_Projects";
      nf = "fastfetch";
      cnf = "clear; fastfetch";
      chrome = "nohup chromium >/dev/null 2>&1 & disown";
      kit = "nohup kitty >/dev/null 2>&1 &disown";
      infovpn = "nmcli connection up openvpn_wolterm1_tcp"; 

    };
    shellInit = "fastfetch";

    ohMyZsh = {
      enable = true;
      theme = "eastwood";
      plugins = [ "git" "dircycle" ];
    };
  };
  users.defaultUserShell = pkgs.zsh;




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
  system.stateVersion = "24.05"; # Did you read the comment?



  #enables flakes and experimental features
  #weekly garbage collector to remove old stores
  nix = {
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "matthiasw" ];
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 7d"; };
  };

}
