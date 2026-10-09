{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./modules/gnome.nix
    ./modules/linux.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/pipewire.nix
    ./modules/programs.nix
    ./modules/users.nix
    ./modules/zsh.nix
  ];
  
  # System version
  system.stateVersion = "26.05";
}
