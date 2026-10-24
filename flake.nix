{
  description = "Git repo: https://github.com/tpmej/nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";    
    nix-crab.url = "github:ItszFinn/nix-crab";
  };

  outputs = { self, nixpkgs, nix-flatpak, nix-crab, ... }@inputs: {
    nixosConfigurations = {
      
      # Main build.
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
        		# Files.
          ./hardware-configuration.nix
          ./configurations/main.nix
          
          # Modules.
          nix-flatpak.nixosModules.nix-flatpak
          nix-crab.nixosModules.default
        ];
      };
    };
  };
}
