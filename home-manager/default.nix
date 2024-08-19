{ lib, pkgs, ... }:
with lib; {
  config = {

    # Install these packages for my user
    home.packages = with pkgs; [
      nixpkgs-fmt
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Include man-pages
    manual.manpages.enable = true;

    programs.command-not-found.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.stateVersion = "24.05";

  };
}
