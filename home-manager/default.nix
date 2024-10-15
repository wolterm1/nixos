{ lib, pkgs, ... }:
{
  imports = [
    ./config/git.nix
    ./config/kitty.nix
    ./config/chromium.nix
    ./config/fastfetch.nix
    ./config/rofi.nix
    #./config/spotify.nix
  ];

  # Install these packages for my user
  home.packages = with pkgs; [
    kitty
    git
    nixpkgs-fmt
    vscode
    chromium
    fastfetch
    spotify-player
    neovim
    rofi
  ];


  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Include man-pages
  manual.manpages.enable = true;

  programs.command-not-found.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.homeDirectory = "/home/matthiasw";
  home.username = "matthiasw";
  home.stateVersion = "24.05";
}
