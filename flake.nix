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
	 
  outputs = { self, nixpkgs, ... }@inputs: 
	let
	system = "x86_64-linux";
	username = "matthiasw";
	lib = nixpkgs.lib;
	pkgs = import nixpkgs {
 		inherit system;
		config.allowUnfree = true;
	}; 

	in{


	nixosConfigurations = {
		matthiasw = lib.nixosSystem {
	    		specialArgs = {inherit inputs system; };
	   		modules = [ 
				./configuration.nix 
	   		];
	 	};
	};


	#hmConfig = {
	#matthiasw = home-manager.lib.homeManagerConfiguration {
	#	pkgs = nixpkgs.legacyPackages.${system};
	#	modules = [
	#		./home.nix
	#	{
	#	home = {
	#		username = "matthiasw";
	#		homeDirectory = "/home/matthiasw";
	#		stateVersion = "24.05";
	#	};			
	#	}
	#	];
	#};
	#};
};
}
