{
  description = "A very basic flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

  };

  outputs = { self, home-manager, hyprland,  ... }@inputs:
    with inputs;
    {

      # 'nix fmt'
      formatter = forAllSystems
        (system: nixpkgsFor.${system}.nixpkgs-fmt);

      # nix build .#nixosConfigurations."matthiasw".config.system.build.toplevel
      nixosConfigurations = {
        matthiasw = nixpkgs.lib.nixosSystem {
	  modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
	    {
    	      home-manager.useGlobalPkgs = true;
 	      home-manager.useUserPackages = true;
 	      home-manager.users.matthiasw = import ./home-manager/default.nix;
	    }
	  ];
        };
      };

      homeConfigurations."matthiasw@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
	{
          wayland.windowManager.hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          };
        }
        # ...
        ];
      };


    };
}
