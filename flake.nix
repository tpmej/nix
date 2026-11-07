{
  description = "Git repo: https://github.com/tpmej/nix";

  inputs = {
  		# Unstable repo.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Declarative flatpak.
    nix-flatpak.url = "github:gmodena/nix-flatpak";    
  };

  outputs = { self, nixpkgs, nix-flatpak, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hardware-configuration.nix
        ./mono.nix
        nix-flatpak.nixosModules.nix-flatpak
      ];
    };
  };
}
