# nixos-rebuild switch --use-remote-sudo --flake .#matthiasw
{
  description = "A very basic flake";

  inputs = {

    # Nix Packages collection
    # https://github.com/NixOS/nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Manage a user environment using Nix 
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, ... }@inputs:
    with inputs;
    let
      supportedSystems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ ]; });
    in
    {

      # Use nixpkgs-fmt for `nix fmt'
      formatter = forAllSystems
        (system: nixpkgsFor.${system}.nixpkgs-fmt);

      # nix build .#nixosConfigurations."matthiasw".config.system.build.toplevel
      nixosConfigurations = {
        matthiasw = nixpkgs.lib.nixosSystem {
          # Make inputs and the flake itself accessible as module parameters.
          # Technically, adding the inputs is redundant as they can be also
          # accessed with flake-self.inputs.X, but adding them individually
          # allows to only pass what is needed to each module.
          specialArgs = { flake-self = self; } // inputs;
          modules = [
            home-manager.nixosModules.home-manager
            ./configuration.nix
            { home-manager.useUserPackages = true; }
          ];
        };
      };

      homeConfigurations = {
        desktop = { pkgs, lib, ... }: {
          imports = [ ./home-manager/default.nix ];
        };
      };

    };
}
