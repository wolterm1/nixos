{ lib, pkgs,  ... }:
{
  imports = [
 	./config/git.nix
	./config/kitty.nix
	./config/chromium.nix
  ];

    # Install these packages for my user
  home.packages = with pkgs; [
    kitty
    git
    nixpkgs-fmt
    vscode	
    neofetch
    chromium
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
