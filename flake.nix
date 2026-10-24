{
  description = "Git repo: https://github.com/tpmej/nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, nix-flatpak, ... }@inputs: {
    nixosConfigurations = {
      
      # Main build.
      main = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./configurations/main.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
  };
}
