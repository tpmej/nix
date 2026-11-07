{ lib, config, pkgs, ... }:
{
  imports =
    let
      # Funkcja pobierająca pliki .nix z bieżącego folderu
      isNixFile = name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix";
      files = builtins.readDir ./.;
      nixFiles = lib.filterAttrs isNixFile files;
    in
      map (name: ./. + "/${name}") (lib.attrNames nixFiles);
}

