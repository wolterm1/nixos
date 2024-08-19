#sudo nixos-rebuild switch --flake .#matthiasw
{
  description = "A very basic flake";
  #unstable?
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    #home-manager = {
    #	url = "github:nix-community/home-manager";
    #	inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, ... }@inputs:
    with inputs;
    let
      supportedSystems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ ]; });
      system = "x86_64-linux";
      username = "matthiasw";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {

      # Use nixpkgs-fmt for `nix fmt'
      formatter = forAllSystems
        (system: nixpkgsFor.${system}.nixpkgs-fmt);

      nixosConfigurations = {
        matthiasw = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./configuration.nix
          ];
        };
      };

      # hmConfig = {
      #   matthiasw = home-manager.lib.homeManagerConfiguration {
      #     pkgs = nixpkgs.legacyPackages.${system};
      #     modules = [
      #       ./home.nix
      #       {
      #         home = {
      #           username = "matthiasw";
      #           homeDirectory = "/home/matthiasw";
      #           stateVersion = "24.05";
      #         };
      #       }
      #     ];
      #   };
      # };
    };
}
