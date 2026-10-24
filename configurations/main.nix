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
  
  # Lua tools.
  # W module systemowym NixOS (włącza modyfikację Steam)
	programs.nix-crab.slssteam-moon.enable = true;
	programs.nix-crab.cloudredirect.enable = true;
	programs.nix-crab.cloudredirect.moon.enable = true;

	# W module Home Manager (instaluje Lumen i wtyczkę LuaTools)
	programs.nix-crab.luatools.enable = true;
	programs.nix-crab.cloudredirect.moon.enable = true;
}
