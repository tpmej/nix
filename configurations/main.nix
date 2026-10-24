{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/gnome.nix
    ./modules/linux.nix
    ./modules/locale.nix
    ./modules/networking.nix
    ./modules/pipewire.nix
    ./modules/programs.nix
    ./modules/users.nix
    ./modules/zsh.nix
  ];
  
  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # System version
  system.stateVersion = "26.05";
}
